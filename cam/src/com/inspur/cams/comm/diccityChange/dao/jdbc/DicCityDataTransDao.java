package com.inspur.cams.comm.diccityChange.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.ExportExcelPageUtil;
import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.diccityChange.dao.IDicCityDataTransDao;
import com.inspur.cams.comm.diccityChange.data.DicCityDataTrans;


/**
 * 数据迁移dao
 * @author 
 * @date 2013-12-23
 */
public class DicCityDataTransDao extends EntityDao<DicCityDataTrans> implements IDicCityDataTransDao {
	
	@Override
	public Class<DicCityDataTrans> getEntityClass() {
		return DicCityDataTrans.class;
	}
	
	public DataSet getUnder(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String ups = (String)pset.getParameter("preChangeCode");
		String xzxhjbquery = (String)pset.getParameter("xzxhjbquery");
		String changeId = (String) pset.getParameter("changeId");
		String batchId = (String) pset.getParameter("batchId");
		List list = null;
		if("3".equals(xzxhjbquery)){
			sql.append("SELECT d.ID ,d.NAME,T.PRE_CHANGE_CODE,T.PRE_CHANGE_NAME, ");
			sql.append("t.TRANS_ID ,T.CHANGE_ID,T.POST_CHANGE_CODE,T.POST_CHANGE_NAME,T.POST_UPS_CODE,T.POST_UPS_NAME,T.TRANS_TYPE ");
			sql.append("  FROM DIC_CITY d ");
			sql.append("  left join dic_city_data_trans t ");
			sql.append("    on t.pre_change_code = d.id ");
			sql.append(" WHERE d.ups = ?  ");
			typeList.add(Types.VARCHAR);
			argsList.add(ups);
			sql.append(" and d.id not in ");
			sql.append(" (select m.PRE_CHANGE_CODE from dic_city_change m where m.batch_id=?) ORDER　BY d.ID ");
			typeList.add(Types.VARCHAR);
			argsList.add(batchId);
		}else if("4".equals(xzxhjbquery)){
			sql.append("SELECT d.ID ,d.NAME,T.PRE_CHANGE_CODE,T.PRE_CHANGE_NAME,");
			sql.append("t.TRANS_ID ,T.CHANGE_ID,T.POST_CHANGE_CODE,T.POST_CHANGE_NAME,T.POST_UPS_CODE,T.POST_UPS_NAME,T.TRANS_TYPE ");
			sql.append("  FROM DIC_CITY d ");
			sql.append("  left join dic_city_data_trans t ");
			sql.append("    on t.pre_change_code = d.id ");
			sql.append(" WHERE d.id = ? ORDER　BY d.ID ");
			typeList.add(Types.VARCHAR);
			argsList.add(ups);
		}else{
			sql.append("SELECT d.ID ,d.NAME,T.PRE_CHANGE_CODE,T.PRE_CHANGE_NAME,");
			sql.append("t.TRANS_ID ,T.CHANGE_ID,T.POST_CHANGE_CODE,T.POST_CHANGE_NAME,T.POST_UPS_CODE,T.POST_UPS_NAME,T.TRANS_TYPE ");
			sql.append("  FROM DIC_CITY d ");
			sql.append("  left join dic_city_data_trans t ");
			sql.append("    on t.pre_change_code = d.id ");
			sql.append(" WHERE 1=1 ");
		}
		if (changeId != null && !changeId.equals("")) {
			sql.append(" and t.CHANGE_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(changeId);
		}
			if(typeList.size()!=0&&argsList.size()!=0){
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++){
					types[i] = (Integer)typeList.get(i);
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				resultDs = this.executeDataset(sql.toString(),types,args,ExportExcelPageUtil.getDsStart(pset),ExportExcelPageUtil.getDsLimit(pset),true);
			}else{
				resultDs = this.executeDataset(sql.toString(),ExportExcelPageUtil.getDsStart(pset),ExportExcelPageUtil.getDsLimit(pset),true);
			}
			return resultDs;
	}

	/**
	 * 调用存储过程迁移业务数据
	 */
	public void transDicCity(String preChangeCode,String postChangeCode) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "BP_AREA_CODE_CHANGE_DETAIL");
		map.put("parameterNum",	2);
		map.put("parameterName_1", "P_PRE_CHANGE_CODE");
		map.put("parameterName_2", "P_POST_CHANGE_CODE");
		map.put("parameterValue_1", preChangeCode);
		map.put("parameterValue_2", postChangeCode);
		map.put("NumberOfResultSet",0);
		new ProceduresUtil().init(getDataSource(),map).call(map);
	}
	public void deleteByTrans(String changeId) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		//清空关系
		sql.append("DELETE FROM DIC_CITY_DATA_TRANS WHERE CHANGE_ID=?");
		typeList.add(Types.VARCHAR);
		objList.add(changeId);

		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
		}
	}
}