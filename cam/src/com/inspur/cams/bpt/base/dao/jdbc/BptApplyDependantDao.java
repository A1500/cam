package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptApplyDependantDao;
import com.inspur.cams.bpt.base.data.BptApplyDependant;

/**
 * @title:BptApplyDependantDao
 * @description:
 * @author:
 * @since:2011-08-10
 * @version:1.0
*/
 public class BptApplyDependantDao extends EntityDao<BptApplyDependant> implements IBptApplyDependantDao{

 	public BptApplyDependantDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptApplyDependant> getEntityClass() {
		return BptApplyDependant.class;
	}
  	
  //删除三属
  	public void deleteDependant (ParameterSet pset){
		String applyId =(String)pset.get("applyId");
		String peopleId =(String)pset.get("peopleId");
		String warOrTest =(String)pset.get("warOrTest");
		int[] type = new int[1];
		Object[] applyid = new Object[1];
		Object[] peopleid= new Object[1];
		type[0]=Types.VARCHAR;
		applyid[0]=applyId;
		peopleid[0]=peopleId;
		if(warOrTest!=null&&"war".equals(warOrTest)){
			this.executeUpdate("DELETE FROM BPT_APPLY_DEPENDANT A WHERE A.APPLY_ID=?",type,applyid);
			this.executeUpdate("DELETE FROM BPT_PEOPLE_WAR D WHERE D.PEOPLE_ID=?",type,peopleid);
			this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.WAR_TYPE_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
			this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.WAR_FLAG='', B.WAR_NO='', B.WAR_STATE_CODE='0'  WHERE B.PEOPLE_ID=?",type,peopleid);
		}else if(warOrTest!=null&&"test".equals(warOrTest)){
			this.executeUpdate("DELETE FROM BPT_APPLY_DEPENDANT A WHERE A.APPLY_ID=?",type,applyid);
			this.executeUpdate("DELETE FROM BPT_PEOPLE_TESTED D WHERE D.PEOPLE_ID=?",type,peopleid);
			this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.WAR_TYPE_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
			this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.WAR_FLAG='', B.WAR_NO='', B.WAR_STATE_CODE='0'  WHERE B.PEOPLE_ID=?",type,peopleid);
		}else{
			this.executeUpdate("DELETE FROM BPT_APPLY_DEPENDANT A WHERE A.APPLY_ID=?",type,applyid);
			this.executeUpdate("DELETE FROM BPT_PEOPLE_DEPENDANT D WHERE D.PEOPLE_ID=?",type,peopleid);
			this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.DEPENDANT_TYPE_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
			this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.DEPENDANT_FLAG='', B.DEPENDANT_NO='', B.DEPENDANT_STATE_CODE='0'  WHERE B.PEOPLE_ID=?",type,peopleid);
		}
	}
  	/**
	 * 查询审批信息
	 * @param applyId
	 * @return
	 */
	public DataSet queryApplyDependant(String applyId) {
		StringBuffer bf = new StringBuffer();
		bf.append(" SELECT B.OBJECT_TYPE, B.APPLY_ID,B.PEOPLE_ID,B.SERVICE_TYPE,B.COMMIT_FLAG, B.APPROVE_DATE,B.APPROVE_ORGAN_ID,");
		bf.append(" P.DEPENDANT_TYPE_CODE,B.TOWN_ADUIT_ADVICE,B.TOWN_ADUIT_INCHARGE,B.TOWN_ADUIT_APPROVE_DATE");
		bf.append(" FROM BPT_APPLY_DEPENDANT B, BPT_PEOPLE P");
		bf.append(" WHERE P.PEOPLE_ID=B.PEOPLE_ID");
		bf.append(" AND B.APPLY_ID = ? ");
		return this.executeDataset(bf.toString(),new int[]{Types.VARCHAR},new Object[]{applyId}, true);
	}
	 
  	
}
