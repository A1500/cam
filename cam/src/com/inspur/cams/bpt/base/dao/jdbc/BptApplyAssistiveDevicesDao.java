package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptApplyAssistiveDevicesDao;
import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices;
import com.inspur.cams.bpt.util.FieldCaseChange;
import com.inspur.cams.bpt.util.FilterLimit;

/**
 * @title:BptApplyAssistiveDevicesDao
 * @description:
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
 public class BptApplyAssistiveDevicesDao extends EntityDao<BptApplyAssistiveDevices> implements IBptApplyAssistiveDevicesDao{

 	public BptApplyAssistiveDevicesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptApplyAssistiveDevices> getEntityClass() {
		return BptApplyAssistiveDevices.class;
	}

   /**
	 * 查询未提交的伤残辅助器械人员信息
	 */
	public DataSet queryUnCommitPeople(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT C.FULL_NAME AS DOMI_NAME,\n");
		sql.append("       P.FAMILY_ID  AS FAMILY_ID,\n");
		sql.append("       P.NAME,\n");
		sql.append("       P.SEX,\n");
		sql.append("       P.NATION,\n");
		sql.append("       P.ID_CARD,\n");
		sql.append("       P.REG_TIME,\n");
		sql.append("       P.DISABILITY_STATE_CODE,\n");
		sql.append("       P.DISABILITY_NO,\n");
		sql.append("       B.DISABILITY_TYPE_CODE,\n");
		sql.append("       D.DISABILITY_LEVEL_CODE,\n");
		sql.append("       D.DISABILITY_CASE_CODE,\n"); 
		sql.append("       D.DISABILITY_GENUS_CODE,\n"); 
		sql.append("       D.PEOPLE_ID,\n");
		sql.append("       A.APPLY_APPARATUS_ID,\n");
		sql.append("       L.APPLY_ID\n");
		sql.append("  FROM BASEINFO_PEOPLE                P,\n");
		sql.append("       BPT_PEOPLE                     B,\n");
		sql.append("       BPT_PEOPLE_DISABILITY          D,\n");
		sql.append("       DIC_CITY                       C,\n");
		sql.append("       BPT_APPLY_ASSISTIVE_DEVICES    A,\n"); 
		sql.append("       BPT_APPLY_ASSISTIVE_DEVICES_PR L\n");
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID\n");
		sql.append("   AND B.PEOPLE_ID = D.PEOPLE_ID\n");
		sql.append("   AND A.APPLY_ID = L.APPLY_ID\n");
		sql.append("   AND P.DISABILITY_FLAG = ? \n");
		sql.append("   AND A.COMMIT_FLAG = ? \n");
		sql.append("   AND P.DOMICILE_CODE = C.ID\n");
		sql.append("   AND P.PEOPLE_ID = A.PEOPLE_ID\n");
		sql.append("   AND L.PEOPLE_ID = A.PEOPLE_ID");
			
		String organCode = (String) pset.getParameter("organCode");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{1,0,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}
	
	/**
	 * 查询伤残辅助器械配置情况
	 */
	public DataSet queryAsisDeviceConfig(ParameterSet pset){
		String peopleId = pset.getParameter("peopleId").toString();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT D.PEOPLE_ID, D.NAME, D.ID_CARD, D.SEX, D.OBJECT_TYPE,\n");
		sql.append("       D.DISABILITY_LEVEL, D.DISABILITY_GENUS, D.DISABILITY_NO,\n") ;
		sql.append("       D.DISABILITY_CASE, D.ADDRESS, D.TEL_MOBILE, D.APPLY_APPARATUS_ID,\n") ; 
		sql.append("       D.APPARATUS_NAME, D.APPLY_CAUSA, D.NOTE, D.REG_ID, D.REG_TIME,\n") ; 
		sql.append("       D.COMMIT_FLAG, D.APPLY_ID, R.APPLY_ID, R.CHECK_INCHARGE,\n") ; 
		sql.append("       R.CHECK_ADVICE, R.CHECK_APPROVE_DATE, R.ADUIT_INCHARGE,\n") ; 
		sql.append("       R.ADUIT_ADVICE, R.ADUIT_APPROVE_DATE, R.AGREE_FLAG, R.REPORT_FLAG,\n") ; 
		sql.append("       R.APPROVE_DATE, R.APPROVE_ORGAN_ID\n") ; 
		sql.append("  FROM BPT_APPLY_ASSISTIVE_DEVICES D, BPT_APPLY_ASSISTIVE_DEVICES_PR R\n") ; 
		sql.append(" WHERE D.APPLY_ID = R.APPLY_ID AND D.PEOPLE_ID = R.PEOPLE_ID AND\n") ; 
		sql.append("       D.PEOPLE_ID = ?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR},new Object[]{peopleId},true);
		DataSet returnDs = new DataSet();
		int i = ds.getCount();
		if(i>0){
			for(Record rd:ds.getRecordSet()){
				Record returnRecord = new Record();
				FieldCaseChange.formatRecord(returnRecord, rd);
				returnDs.add(returnRecord);
			}
			returnDs.setTotalCount(i);
		}
		return returnDs;
	}
	
	public void updatePeopleDevices(Record[] rs, String applyId ){
		StringBuffer sql = new StringBuffer();
		sql.append("delete from BPT_PEOPLE_DEVICES t where t.apply_id='").append(applyId).append("'");
		this.executeUpdate(sql.toString());
		
		for(int i=0 ;i<rs.length;i++){
			sql= new StringBuffer();
			sql.append("insert into BPT_PEOPLE_DEVICES (apply_id,device_id,num)  values (?,?,?)");
			this.executeUpdate(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
					new Object[]{applyId,rs[i].get("applyApparatusId"),rs[i].get("num")});
		}
	}
}
