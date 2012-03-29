time_start = Time.now

filename = 'access_log_27_03.log'
# filename = 'access_log_test.log'
# filename = 'seo_pages.log'
target_file = 'unique_ips.txt'
result_arr = []

file_from = File.new(filename, 'r')
file_to = File.new(target_file, 'w')

file_from.each do |row|
	# if ((row =~ /\/article\// || row =~ /\/article\s/ || row =~ /GET\s\/\sHTTP\/1\.1\// || row =~ /\/country/) && row =~ /178\.154\.161\.29/)
	# if (row =~ /178\.154\.161\.29/)
	ip = row.scan(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/)[0].to_s.strip
		unless result_arr.include?(ip)
			result_arr << ip
			file_to.puts(ip)
		end
	# file_to.puts(row) if ips.include?(ip)
end

puts "Обработка закончена. Обработка заняла #{Time.now - time_start} секунд."