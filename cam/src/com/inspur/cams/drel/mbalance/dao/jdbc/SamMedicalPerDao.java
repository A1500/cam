package com.inspur.cams.drel.mbalance.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalPerDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalPer;
/***
 * 一站结算_救助比例dao实现
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalPerDao  extends EntityDao<SamMedicalPer> implements ISamMedicalPerDao{

	@Override
	protected Class<SamMedicalPer> getEntityClass() {
		// TODO Auto-generated method stub
		return SamMedicalPer.class;
	}

	public DataSet queryPer(String domicileCode, String payBase,
			String assitanceType) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select * from sam_medical_per a \n");
		sql.append("  where a.domicile_code = '"+domicileCode.substring(0,6)+"000000"+"'  \n");
		sql.append("  and a.lower_limit <= '"+payBase+"' \n");
		sql.append("     and a.upper_limit > '"+payBase+"' \n");
		sql.append("     and a.type = '"+assitanceType+"' \n");
		sql.append("  and a.year='"+DateUtil.getYear()+"' \n");
		return executeDataset(sql.toString(), true);
	}
	
	

}