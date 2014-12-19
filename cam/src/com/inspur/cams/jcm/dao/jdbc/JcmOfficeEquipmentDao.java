package com.inspur.cams.jcm.dao.jdbc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;
import com.inspur.cams.jcm.dao.IJcmOfficeEquipmentDao;
import com.inspur.cams.jcm.data.JcmOfficeEquipment;

/**
 * 办公设备信息dao
 * @author 
 * @date 2014-05-16
 */
public class JcmOfficeEquipmentDao extends EntityDao<JcmOfficeEquipment> implements IJcmOfficeEquipmentDao {
	
	@Override
	public Class<JcmOfficeEquipment> getEntityClass() {
		return JcmOfficeEquipment.class;
	}
	
	/**
	 * 查询 办公设备信息
	 * @param pset
	 * @return
	 */
	public DataSet queryEquipmentInfo(ParameterSet pset){
		String areaCode=(String)pset.getParameter("areaCode");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "JCM_EQUIPMENT_INFO_REPORT");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "areaCode");
		map.put("NumberOfResultSet",1);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", areaCode);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		set = ProceduresUtil.fixDataSet(set);
		return set;
	}

}