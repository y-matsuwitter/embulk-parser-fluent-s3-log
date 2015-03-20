require "stringio"

module Embulk
  module Parser

    class FluentS3LogParserPlugin < ParserPlugin
      Plugin.register_parser("fluent-s3-log", self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          :columns => config.param("columns", :array)
        }

        columns = task[:columns].each_with_index.map do |c, i|
          Column.new(i+2, c["name"], c["type"].to_sym)
        end
        columns.insert(0, Column.new(0, "time", :timestamp))
        columns.insert(1, Column.new(1, "key", :string))
        yield(task, columns)
      end

      def run(file_input)
        while file = file_input.next_file
          StringIO.new(file.read).each_line do |buffer|
            # parsering code
            splitted = buffer.split("\t")
            record = [
              Time.strptime(splitted[0], "%Y-%m-%dT%H:%M:%S%Z"),
              splitted[1]
            ]
            j = JSON.parse(splitted[2])
            record += make_record(@task["columns"], j)
            page_builder.add(record)
          end
        end
        page_builder.finish
      end
      private

      def make_record(schema, e)
        schema.map do |c|
          name = c["name"]
          val = e[name]

          v = val.nil? ? "" : val
          type = c["type"]
          case type
            when "string"
              v
            when "long"
              v.to_i
            when "double"
              v.to_f
            when "boolean"
              ["yes", "true", "1"].include?(v.downcase)
            when "timestamp"
              v.empty? ? nil : Time.strptime(v, c["format"])
            else
              raise "Unsupported type #{type}"
          end
        end
      end
    end

  end
end
