package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IDemobilizedflowDao;
import com.inspur.cams.bpt.base.data.Demobilizedflow;

/**
 * @title:DemobilizedflowDao
 * @description:
 * @author:
 * @since:2011-07-29
 * @version:1.0
 */
public class DemobilizedflowDao extends EntityDao<Demobilizedflow> implements
		IDemobilizedflowDao {

	public DemobilizedflowDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<Demobilizedflow> getEntityClass() {
		return Demobilizedflow.class;
	}
	public void deleteDemobilized (ParameterSet pset){
		String applyId =(String)pset.get("applyId");
		String peopleId =(String)pset.get("peopleId");
		int[] type = new int[1];
		Object[] applyid = new Object[1];
		Object[] peopleid= new Object[1];
		type[0]=Types.VARCHAR;
		applyid[0]=applyId;
		peopleid[0]=peopleId;
		this.executeUpdate(" DELETE FROM BPT_APPLY_DEMOBILIZED A WHERE A.APPLY_ID=?",type,applyid);
		this.executeUpdate("DELETE FROM BPT_DECISION_LETTER E WHERE E.APPLY_ID =?",type,applyid);
		this.executeUpdate("DELETE BPT_DISABILITY_OPEN WHERE APPLY_ID=?", type, applyid);
		this.executeUpdate("DELETE FROM BPT_PEOPLE_DEMOBILIZED D WHERE D.PEOPLE_ID=?",type,peopleid);
		this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.DEMOBILIZED_TYEP_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
		this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.DEMOBILIZED_FLAG='', B.DEMOBILIZED_NO='', B.DEMOBILIZED_STATE_CODE='0' WHERE B.PEOPLE_ID=?",type,peopleid);
	}
	
	//删除带病回乡
	public void deleteDemobilizedIll (ParameterSet pset){
		String applyId =(String)pset.get("applyId");
		String peopleId =(String)pset.get("peopleId");
		int[] type = new int[1];
		Object[] applyid = new Object[1];
		Object[] peopleid= new Object[1];
		type[0]=Types.VARCHAR;
		applyid[0]=applyId;
		peopleid[0]=peopleId;
		this.executeUpdate(" DELETE FROM BPT_APPLY_DEMOBILIZED A WHERE A.APPLY_ID=?",type,applyid);
		this.executeUpdate("DELETE FROM BPT_DECISION_LETTER E WHERE E.APPLY_ID =?",type,applyid);
		this.executeUpdate("DELETE FROM bpt_demobilizedillness_check p WHERE p.APPLY_ID =?",type,applyid);
		this.executeUpdate("DELETE BPT_DISABILITY_OPEN WHERE APPLY_ID=?", type, applyid);
		this.executeUpdate("DELETE FROM BPT_PEOPLE_DEMOBILIZED_ILLNESS D WHERE D.PEOPLE_ID=?",type,peopleid);
		this.executeUpdate("DELETE BPT_PHYSICAL_EXAMINATION  WHERE APPLY_ID=?", type, applyid);
		this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.DEMOBILIZED_TYEP_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
		this.executeUpdate("UPDATE BASEINFO_PEOPLE B SET B.DEMOBILIZED_FLAG='', B.DEMOBILIZED_NO='', B.DEMOBILIZED_STATE_CODE='0' WHERE B.PEOPLE_ID=?",type,peopleid);
	}

	public DataSet queryDemobilized(ParameterSet pset) {
		pset.getParameter("");
		String sql = "";
		return null;
	}

	public DataSet query1(ParameterSet pset) {
		return null;
	}


	public void updateExchaCertiDemo(Demobilizedflow dateBean) {
		String applyId = dateBean.getApplyId();
		String exchangeReason = dateBean.getExchangeReason();
		String sql = " UPDATE BPT_APPLY_DEMOBILIZED SET EXCHANGE_REASON= ? WHERE APPLY_ID= ? ";
		executeUpdate(sql,new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{exchangeReason,applyId});
	}
	
	//修改在乡复员流程审批表
	public void updateFlow(Demobilizedflow demobilizedflowDevices) {
		String applyId = "";
		String sql = "";
		if(demobilizedflowDevices.getExchacertiCommitFlag()==null){
			applyId= demobilizedflowDevices.getApplyId();
			sql=" UPDATE BPT_APPLY_DEMOBILIZED SET COMMIT_FLAG='1' WHERE APPLY_ID = ? ";
		}else{
			applyId= demobilizedflowDevices.getApplyId();
			sql=" UPDATE BPT_APPLY_DEMOBILIZED SET EXCHACERTI_COMMIT_FLAG='1' WHERE APPLY_ID= ? ";
			executeUpdate(sql);
		}
		executeUpdate(sql,new int[]{Types.VARCHAR},new Object[]{applyId});
	}

}
