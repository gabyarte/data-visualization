library(shiny)
library(readr)
library(ggplot2)
library(dplyr)



df <- read_csv("./input/annual_visitors.csv")
head(annual_visitors_3)


df$annual_visitors

total = sum(df$annual_visitors_2)

as.numeric(annual_visitors_2$income)

agg_tbl <- annual_visitors_3 %>% group_by(year) %>% 
  summarise(sum_salary = sum(annual_visitors),
            avg_income = max(income),
            .groups = 'drop')
df2 <- agg_tbl %>% as.data.frame()
df2





df_annual_visitors <- read.csv("./input/annual_visitors_air.csv")

ggplot(df, aes(x=years, y=visitors, colour="contries")) +
  geom_line(stat='identity')


ggplot(crime_data_city, aes_string(x= "year", y= input$crime_type, colour= "department_name")) +
  geom_line() +
  geom_point(size= 3, alpha= input$alpha_input) +
  coord_cartesian(xlim=c(min_year, max_year)) +
  scale_color_discrete(name = "City") +
  ggtitle(plot_title) +
  theme(plot.title = element_text(size = 20, hjust = 0.5, colour = input$col),
        axis.title.y = element_text(size = 13, vjust=0.5, angle = 0),
        axis.title.x = element_text(size = 13, angle = 0),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size =12)
  )


crime_data5$X2014
crime_data5$age_group
