package com.inspur.cams.welfare.welfarecorp.query.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.data.WealUnitStatus;

import org.loushang.next.dao.BaseCURD;


/**
 * @title:福利企业情况统计Dao
 * @description:
 * @author: sunlei
 * @since:2013-12-26
 * @version:1.0
*/
 public interface IUnitReportDao extends BaseCURD<WealUnitStatus>{
	 /**
	  * @title:基本情况情况统计
	  * @description:
	  * @author: sunlei
	  * @since:2013-12-26
	  * @version:1.0
	 */
		public DataSet queryBaseinfoReport(ParameterSet pset);
		
}