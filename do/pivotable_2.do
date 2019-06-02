
			************************************************
			****				Stata之禅				****
			****			the Zen of Stata			****
			************************************************

* Pivotable 1

import excel "机构退出列表.xls", sheet("许可证情况导出") firstrow clear
drop 经度 纬度 机构地址
gen year = yofd(date(批准成立日期, "YMD")) 		// 银行分支机构成立年份
gen quit_year = yofd(date(发生日期, "YMD"))  	// 银行分支机构退出年份
gen age = quit_year - year + 1 					// 存续时间



*=tabstat=
tabstat 流水号, by(省份) s(n) 

bysort year: tabstat 流水号, by(省份) s(n) 

*=tabulate=

tabulate 省份, sum(流水号) obs

tabulate 省份, sum(流水号) nomeans nost nofr obs

tabulate 省份 year, sum(流水号) nomeans nost nofr obs //too many values

tabulate 省份 year if year>=2009, sum(流水号) nomeans nost nofr obs wrap

*=table=

table 省份, c(count 流水号)

table 省份 year if year>=2009, c(count 流水号)

table 省份 year if year>=2009, c(count 流水号) row column
		 

	