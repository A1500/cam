package com.inspur.cams.fis.ep.base.dao.jdbc;

import java.sql.Types;

import org.loushang.bsp.util.StringUtil;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckInfoDao;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckInfo;
import com.inspur.cams.fis.ep.util.RecordToBean;

/**
 * @title: FisCemeCheckInfoDao
 * @description:
 * @author:
 * @since:2011-11-17
 * @version:1.0
 */
public class FisCemeCheckInfoDao extends EntityDao<FisCemeCheckInfo> implements
		IFisCemeCheckInfoDao {

	public FisCemeCheckInfoDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCemeCheckInfo.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from CemeInspection");
	}

	public DataSet queryForCemeInfo(ParameterSet pset) {
		DataSet ds = new DataSet();
		DataSet tempDs = null;
		// 公墓ID
		String cemeId = (String) pset.getParameter("CEME_ID");
		// 年检次数
		String applyId = (String) pset.getParameter("APPLY_ID");

		StringBuffer sql = new StringBuffer();
		if(StringUtil.isEmptyString(applyId)) {
			//未年检公墓
			sql.append("SELECT T.* FROM FIS_CEME_INFO T WHERE T.CEME_ID=?");
			int[] types = new int[1];
			Object[] args = new Object[1];
			types[0]=Types.VARCHAR;
			args[0]=cemeId;
			
			tempDs = this.executeDataset(sql.toString(), types, args, true);
		} else {
			//已年检公墓
			sql.append("SELECT C.*,T.* FROM FIS_CEME_CHECK_INFO C LEFT JOIN FIS_CEME_INFO T ON C.CEME_ID=T.CEME_ID");
			sql.append(" WHERE C.APPLY_ID=? ORDER BY C.REPORT_TIME DESC");
			
			int[] types = new int[1];
			Object[] args = new Object[1];
			types[0]=Types.VARCHAR;
			args[0]=applyId;
			
			tempDs = this.executeDataset(sql.toString(), types, args, true);
		}
		
		
		for(int i=0;i<tempDs.getCount();i++) {
			FisCemeCheckInfo fisCemeCheckInfo = RecordToBean.getFisCemeCheckInfo(tempDs.getRecord(i));
			ds.addRecord(fisCemeCheckInfo);
		}
		ds.setTotalCount(tempDs.getCount());
		
		return ds;
	}
	
	//上报公益性公墓
	public void reportNoProfitCheck(String endApplyId) {
		String date = com.inspur.cams.comm.util.DateUtil.getTime();
		String user = BspUtil.getEmpOrganId();
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_INFO T SET T.IS_REPORT='1',T.REPORT_TIME=?,T.REPORT_PERSON=? WHERE T.APPLY_ID=?");
		
		int[] types = new int[3];
		Object[] args = new Object[3];
		
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		args[0]=date;
		args[1]=user;
		args[2]=endApplyId;
		
		executeUpdate(sql.toString(), types, args);
	}
	
	//上报经营性公墓-检查
	public void reportProfitCheck(String endApplyId) {
		String date = com.inspur.cams.comm.util.DateUtil.getTime();
		String user = BspUtil.getEmpOrganId();
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_INFO T SET T.IS_REPORT='1',T.REPORT_TIME=?,T.REPORT_PERSON=? WHERE T.APPLY_ID=?");
		
		int[] types = new int[3];
		Object[] args = new Object[3];
		
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		args[0]=date;
		args[1]=user;
		args[2]=endApplyId;
		
		executeUpdate(sql.toString(), types, args);
	}

	//上报经营性公墓-年检
	public void reportProfitFinalCheck(String endApplyId) {
		String date = com.inspur.cams.comm.util.DateUtil.getTime();
		String user = BspUtil.getEmpOrganId();
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_INFO T SET T.IS_REPORT='1',T.REPORT_TIME=?,T.REPORT_PERSON=? WHERE T.APPLY_ID=?");
		
		int[] types = new int[3];
		Object[] args = new Object[3];
		
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		args[0]=date;
		args[1]=user;
		args[2]=endApplyId;
		
		executeUpdate(sql.toString(), types, args);
	}
}
