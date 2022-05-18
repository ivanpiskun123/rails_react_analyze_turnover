class PagesController < ApplicationController

      def home
      end


      def get_years
        render json: {
          data: {"years": Month.all.to_a.uniq{|m| m.date.year }.map{|m_uniq_year| m_uniq_year.date.year}.sort()}
        }, status: :ok
      end


       def index
         @dynamic_indexed_chart = []

         sum_sales_year = 0
         sum_plan_year = 0
         sum_prices =0
         sales_count = 0
         wholesale_sum = 0

          Month.of_specific_year(params[:year]).each do |m|
            @dynamic_indexed_chart << [m.russian_name_of_month, m.sales_sum_indexed]
            sum_sales_year += m.sales_sum
            sum_plan_year += m.sales_plan
            m.sales.each do |s|
              sales_count += 1
              sum_prices += s.product_unit_price
              wholesale_sum += s.total_sum if s.is_wholesale?
            end
          end

          @product_group_data = ProductGroup.all.map {|pg| [pg.name, pg.sales_sum_by_year(params[:year])] }

          @average_price_chart = []
          Month.of_specific_year(params[:year]).each do |m|
            @average_price_chart << [m.russian_name_of_month, m.average_sales_price]
          end

          @wholesale_percentage = (wholesale_sum.to_f*100 / sum_sales_year).round(0)
          @execution_percentage = (sum_sales_year.to_f*100 / sum_plan_year).round(0)
          @average_price = (sum_prices / sales_count).round(1)





       end

       def dynamic_plan_execution

         @dynamic_plan_chart_exec = []
         @dynamic_plan_chart_plan = []
         @dynamic_plan_data = []

         Month.of_specific_year(params[:year]).each do |m|
           @dynamic_plan_chart_exec << [m.russian_name_of_month, m.sales_sum]
           @dynamic_plan_chart_plan << [m.russian_name_of_month, m.sales_plan]
            @dynamic_plan_data << [
              m.month_number,
              m.russian_name_of_month,
              m.sales_plan,
              m.sales_sum,
              (m.plan_compl_percent*100).round(2)
            ]
         end

         render json: {
           data: {"exec": @dynamic_plan_chart_exec,
                  "plan": @dynamic_plan_chart_plan, "table": @dynamic_plan_data}
         }, status: :ok

       end

       def dynamic_indexed_sales
         @dynamic_plan_chart_exec = []
         @dynamic_plan_chart_plan = []
         @dynamic_plan_chart_index = []
         @index_data = []

         Month.of_specific_year(params[:year]).each do |m|
           @dynamic_plan_chart_exec << [m.russian_name_of_month, m.sales_sum]
           @dynamic_plan_chart_plan << [m.russian_name_of_month, m.sales_plan]
           @dynamic_plan_chart_index << [m.russian_name_of_month, m.sales_sum_indexed]
           @index_data << [
              m.month_number,
              m.russian_name_of_month,
              m.sales_sum,
              m.price_index,
              m.sales_sum_indexed,
              m.growth_rate_percent,
              m.rate_of_increase_percent
            ]
         end

         render json: {
           data: {"exec": @dynamic_plan_chart_exec,
                  "plan": @dynamic_plan_chart_plan, index: @dynamic_plan_chart_index, "table": @index_data}
         }, status: :ok


       end

       def product_group_structure
         @chart = []
         @data = []

         @chart = ProductGroup.all.map {|pg| [pg.name, pg.sales_sum_by_year(params[:year])] }
          @data = @chart

         render json: {
           data: {"groups": @data}
         }, status: :ok

       end

       def payment_method_sctructure
         @data = [ ["Наличный расчет" ,Sale.of_specific_year(params[:year]).in_cash.count], ["Эл. перевод", Sale.of_specific_year(params[:year]).in_transaction.count] ]


         render json: {
           data: {"payment_forms": @data}
         }, status: :ok
       end

       def trade_form_sctructure
         @data =   [ ["Оптовые продажи" ,Sale.of_specific_year(params[:year]).is_wholesale.count], ["Продажи в розницу", Sale.of_specific_year(params[:year]).is_retail.count] ]

         render json: {
           data: {"trade_forms": @data}
         }, status: :ok
       end

       def seasonality_sctructure
         @data = [
           ["1 квартал", get_sales_for_specific_season_and_year(params[:year], [1,3]  ).round(2)  ],
           ["2 квартал",  get_sales_for_specific_season_and_year(params[:year], [4,6]  ).round(2) ],
           ["3 квартал", get_sales_for_specific_season_and_year(params[:year], [7,9]  ).round(2)   ],
           ["4 квартал", get_sales_for_specific_season_and_year(params[:year], [10,12]  ).round(2) ]
         ]

         render json: {
           data: {"seasons": @data}
         }, status: :ok

       end

       # def average_prices
       #   @chart = []
       #   @data = []
       #   Month.of_specific_year(params[:year]).each do |m|
       #      @chart << [m.russian_name_of_month, m.average_sales_price]
       #       @data << [
       #         m.month_number,
       #         m.russian_name_of_month,
       #         m.average_sales_price
       #       ]
       #   end
       #
       # end

       def abs_product_analysis
         @data = abc_product_analysis(params[:year])

         render json: {
           data: {"abc": @data}
         }, status: :ok
       end

      def xyz_analysis
        @data_products = xyz_product_analysis(params[:year])
        @data_groups = xyz_groups_analysis(params[:year])

        render json: {
          data: {"xyz_prod": @data_products, "xyz_group": @data_groups,}
        }, status: :ok
      end


       # def sales_forecast
       #
       #   month_count = params[:month_count].to_i
       #   depth = month_count / 3
       #   @depth = depth
       #   @month_count = month_count
       #   # write input data about sales to input_data file
       #   file = File.open("lib/assets/python/input_data.txt", "w")
       #   Product.all.each do |p|
       #     Month.last(month_count).each do |m|
       #      file.write( m.sales.where(product: p).to_a.sum(&:total_sum).to_s + " " )
       #     end
       #     file.write("\n")
       #   end
       #   file.close
       #
       #   # run forecasting and output data to results.txt file
       #   run_NN_forecasting()
       #
       #   @charts = []
       #   #read and build charts-data for presentation of forecasting results
       #   file = File.open("lib/assets/python/results.txt")
       #   max_lines_values = []
       #   @t_data = Array.new(month_count+depth) {Array.new(Product.count+1)}
       #
       #  file.readlines.each_with_index do |line, idx|
       #    chart = []
       #    chart << [ Product.find(idx+1).name]
       #    values = line.split().map{|e| e.to_i }
       #    values.each_with_index {|v, i| @t_data[i][idx+1]=v }
       #
       #    max_lines_values << values.max()
       #    data = []
       #
       #    month_count.times do |m_idx|
       #        data << [ Month.last.date-(month_count-1-m_idx).month  , values[m_idx] ]
       #    end
       #
       #    depth.times do |mn_idx|
       #      data << [ Month.last.date+(mn_idx+1).month  , values[month_count+mn_idx] ]
       #    end
       #
       #    chart << data
       #    @charts << chart
       #  end
       #
       #  file.close
       #
       #  month_count.times do |m_idx|
       #      @t_data[m_idx][0] = Month.last.date-(month_count-1-m_idx).month
       #  end
       #
       #  depth.times do |mn_idx|
       #      @t_data[month_count+mn_idx][0] = Month.last.date+(mn_idx+1).month
       #  end
       #
       #
       #
       # end


       private

       def get_sales_for_specific_season_and_year(year, season_start_end_month_n)
           Month.where(date: ( Date.parse("1-#{season_start_end_month_n[0]}-#{year}").end_of_month .. Date.parse("1-#{season_start_end_month_n[1]}-#{year}").end_of_month )).to_a.sum(&:sales_sum_indexed)
       end

       # def abc_product_analysis(year)
       #   total_sales_sum_by_year = Sale.of_specific_year_to_array(year).sum(&:total_sum)
       #
       #   product_ordered_by_sales =  Product.all.to_a.sort { |a,b|  a.sales_sum_by_year(year) <=> b.sales_sum_by_year(year)   }
       #   product_ordered_by_sales = product_ordered_by_sales.reverse()
       #   additional_part = 0.0
       #   abc_product_data = []
       #
       #   product_ordered_by_sales.each_with_index do |p, idx|
       #       sales_sum_product = p.sales_sum_by_year(year)
       #       part = sales_sum_product.to_f/total_sales_sum_by_year.to_f
       #       additional_part += part
       #
       #       case additional_part
       #       when 0.0 .. 0.7
       #           group = "A"
       #         when 0.7 .. 0.95
       #           group = "B"
       #         when 0.95 .. 100.0
       #           group = "C"
       #       end
       #
       #       abc_product_data << [idx+1, p.name, sales_sum_product , (part*100).round(2), additional_part.round(1), group]
       #     end
       #
       #     abc_product_data
       # end

      def xyz_product_analysis(year)
        xyz_data = []
        Product.all.each do |p|
          prod_sales = []
          ms = Month.of_specific_year(year)

          ms.each do |m|
            prod_sales << m.sales.where(product_id: p.id).to_a.sum(&:total_sum)
          end

          sum_diffs = 0
          (0..(prod_sales.count-2)).each{|i| sum_diffs += ( prod_sales[i] - prod_sales[i+1] ).abs }

          average_sale = prod_sales.sum.to_f/prod_sales.count.to_f

          sigma = ((sum_diffs)/(prod_sales.count-1)).to_f/average_sale

          group = "X"
          case sigma
          when 0.0 .. 0.35
            group = "X"
          when 0.35 .. 0.78
            group = "Y"
            else
            group = "Z"
          end
          xyz_data << [p.name, group, sigma]
        end

        xyz_data_sorted =  xyz_data.sort { |a,b|  a[2] <=> b[2]   }
        xyz_data_sorted

      end

      def xyz_groups_analysis(year)
        xyz_data = []
        ProductGroup.all.each do |p|
          group_sales = []
          ms = Month.of_specific_year(year)
          prd_ids = p.products.map(&:id)
          ms.each do |m|
            group_sales << m.sales.where(product_id: prd_ids).to_a.sum(&:total_sum)
          end

          sum_diffs = 0
          (0..(group_sales.count-2)).each{|i| sum_diffs += ( group_sales[i] - group_sales[i+1] ).abs }

          average_sale = group_sales.sum.to_f/group_sales.count.to_f

          sigma = ((sum_diffs)/(group_sales.count-1)).to_f/average_sale

          group = "X"
          case sigma
          when 0.0 .. 0.35
            group = "X"
          when 0.35 .. 0.78
            group = "Y"
          else
            group = "Z"
          end
          xyz_data << [p.name, group, sigma]
        end

        xyz_data_sorted =  xyz_data.sort { |a,b|  a[2] <=> b[2]   }
        xyz_data_sorted
      end

       def set_current_year
         @current_year = params[:year]
       end



       def get_file_name_from_path(full_path)
          full_path.split("\\")[-1]
        end

        def run_NN_forecasting
            system("python lib/assets/python/forecast_LSTM_NN.py")
        end

      def list_years
        Month.all.to_a.uniq{|m| m.date.year }.map{|m_uniq_year| m_uniq_year.date.year}.sort()
      end

end
