library(ggplot2)
library(plotly)
library(htmlwidgets)
library(widgetframe)
library(utils)
library(lubridate)
theme_set(theme_classic())
# data <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv",
#                  na.strings = "", fileEncoding = "UTF-8-BOM")
colnames(data)
lbls <- paste0(month.abb[month(data$dateRep)]) #, " ", lubridate::year(data$date)
brks <- data$dateRep

typeof(data$dateRep)
typeof(lbls)
typeof(brks)


# data$dateRep
# data$date <- as.Date(data$dateRep)
# typeof(data$date)

g <- ggplot(data, aes(x=as.Date(date))) +
  geom_line(aes(y=cases)) +
  labs(title="Cases over time",
       caption="Source: EUCDC",
       y="Cases") + #Title & Caption
  scale_x_date(labels = lbls,
               breaks = brks)

# .libPaths("C:\users\Daniel Le Compte\OneDrive\Documents\DecisiveAction-main\StatsAndVisualizations")

p <- plotly::ggplotly(g)
p

# Not totally sure, but this function will test if the plot and file are there
# If not, will write. Will overwrite if some other thing is true?
save_leaflet <- function(plot=p, file="p1.html", overwrite = FALSE){
  # save the file if it doesn't already exist or if overwrite == TRUE
  if( !file.exists(file) | overwrite ){
    withr::with_dir(new = dirname(file), 
                    code = htmlwidgets::saveWidget(plot, 
                                                   file = basename(file)))
  } else {
    print("File already exists and 'overwrite' == FALSE. Nothing saved to file.")
  }
}

save_leaflet()




p
# saveWidget(p, file="p1.html", selfcontained = F, libdir = "C:\Users\Daniel Le Compte\OneDrive\Documents\DecisiveAction-main\StatsAndVisualizations\lib")
htmltools::tags$iframe(
  src = "p1.html", 
  scrolling = "no", 
  seamless = "seamless",
  frameBorder = "0"
)

# getwd()
# dir()


# widget_file_size <- function(p) {
#   d <- tempdir()
#   withr::with_dir(d, htmlwidgets::saveWidget(p, "index.html"))
#   f <- file.path(d, "index.html")
#   mb <- round(file.info(f)$size / 1e6, 3)
#   message("File is: ", mb," MB")
# }
# widget_file_size(p)
# widget_file_size(partial_bundle(p))


# p <- plot_ly(x = 1:10, y = 1:10) %>% add_markers()
# widget_file_size <- function(p) {
#   d <- tempdir()
#   withr::with_dir(d, htmlwidgets::saveWidget(p, "index.html"))
#   f <- file.path(d, "index.html")
#   mb <- round(file.info(f)$size / 1e6, 3)
#   message("File is: ", mb," MB")
# }
# widget_file_size(p)
# widget_file_size(partial_bundle(p))
# p
# saveWidget(p, "p1.html", selfcontained = F, libdir = "lib")
# htmltools::tags$iframe(
#   src = "p1.html", 
#   scrolling = "no", 
#   seamless = "seamless",
#   frameBorder = "0"
# )
