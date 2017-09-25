# **获取国家社科基金项目数据**

# 打开 [国家社科基金项目数据库](http://fz.people.com.cn/skygb/sk/)，底部直接有总页数。与自然科学基金相比，社科基金数据库内容更加详细，然而关键的金额却没有。

# 查看网站上的总页数，2017-09-26 日时有 3130 页

library(XML)

Page2 <- 3130
URL2 <- as.vector(paste0("http://fz.people.com.cn/skygb/sk/?&p=", 1:Page2))

Social <- data.frame()
i <- 1
for (i in 1:Page2){
  D2 <- as.data.frame(readHTMLTable(URL2[i]))[23:42, 1:20]
  Social <- rbind(Social, D2)
  print(i)
  i <- i + 1
}

D <- as.data.frame(readHTMLTable(URL2[1], stringsAsFactors = FALSE))[22, 1:20]
names(Social) <- D

file_name <- paste0('social-', Sys.Date(), '.csv')
# 保存时最好以抓取日期命名
write.csv(Social, file_name, row.names = F)
