package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptApplyHistoryDao;
import com.inspur.cams.bpt.base.data.BptApplyHistory;

public class BptApplyHistoryDao extends EntityDao<BptApplyHistory> implements
		IBptApplyHistoryDao {

	public BptApplyHistoryDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	protected Class<BptApplyHistory> getEntityClass() {
		return BptApplyHistory.class;
	}
	
	/**
	 * 根据applyId删除历史表信息
	 * @param pset
	 */
	public void delHistoryByApplyId(ParameterSet pset){
		String applyId =(String)pset.get("applyId");
		int[] type = new int[1];
		Object[] applyid = new Object[1];
		type[0]=Types.VARCHAR;
		applyid[0]=applyId;
		this.executeUpdate("DELETE FROM BPT_APPLY_HISTORY A WHERE A.APPLY_ID=?",type,applyid);
	}
}
