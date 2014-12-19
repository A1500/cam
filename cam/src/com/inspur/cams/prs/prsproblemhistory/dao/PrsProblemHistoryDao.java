package com.inspur.cams.prs.prsproblemhistory.dao;

import java.sql.Types;
import com.inspur.cams.prs.util.PrsSQL;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:PrsProblemHistoryDao
 * @description:
 * @author:
 * @since:2011-08-29
 * @version:1.0
*/
 public class PrsProblemHistoryDao extends EntityDao<PrsProblemHistory> implements IPrsProblemHistoryDao{

 	public PrsProblemHistoryDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return PrsProblemHistory.class;
	}
   /**
    * 转发的问题办理完结，更改历史表中的办理状态
    */
   public void updateDealFlag(String problemId){
  	   executeUpdate(PrsSQL.UPDATE_PRS_PROBLEM_HISTORY_BY_PROBLEM_ID,new int[]{Types.VARCHAR},new Object[]{problemId});
     }

}
