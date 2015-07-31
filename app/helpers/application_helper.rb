module ApplicationHelper
	def type(type)
        case type
        when 0
            "Carrier"
        when 1
            "Customer"
        end
    end
end
