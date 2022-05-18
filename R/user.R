#' 写入用户便利店
#'
#' @param token 口令
#' @param file_name  文件名
#' @param app_id 程序名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' userInfo_add()
userInfo_add <- function(token='36F0DB19-AC55-4062-B2DA-39DC39B297BE',
                         file_name = "data-raw/jh_dms_users.xlsx",
                         app_id ='jhdms') {
  data <- readxl::read_excel(file_name)
  data2 = reshape2::melt(data,id.vars = c('Fuser'),variable.name = 'Fkey',value.name = 'Fvalue')
  data2$FappId <- app_id
  data2 = data2[order(data2$Fuser,data2$Fkey),c('FappId','Fuser','Fkey','Fvalue')]
  conn <- tsda::sql_getConn(token = token)
  tsda::db_writeTable(conn = conn,table_name = 't_md_userInfo',r_object = data2,append = T)
  return(data2)
}
