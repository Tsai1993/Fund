library(XML)

# 查看网站上的总页数，2017-09-26 日时有 1793 页
Page <- 1793
URL <- as.vector(paste0("http://www.nsfcms.org/index.php?r=search/index&Projects_page=",
                        1:Page))

Natural <- data.frame()
i <- 1
for (i in 1:Page){
  D1 <- as.data.frame(readHTMLTable(URL[i]))
  Natural <- rbind(Natural, D1)
  print(i)
  i <- i + 1
}

names(Natural) <- c("项目批准号", "项目类别", "项目名称", "依托单位",
                    "负责人", "金额", "起止年月","总评")

file_name <- paste0('natural-', Sys.Date(), '.csv')

# 保存时最好以抓取日期命名
write.csv(Natural, file_name, row.names = F)
