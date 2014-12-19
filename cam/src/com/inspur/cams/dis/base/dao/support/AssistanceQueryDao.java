package com.inspur.cams.dis.base.dao.support;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.ResultReader;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.Procedure;
import org.loushang.persistent.util.domain.BaseJdbcDao;

@SuppressWarnings("unchecked")
public class AssistanceQueryDao extends BaseJdbcDao{
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
	public DataSet queryAssistance(ParameterSet pset){
		StringBuffer sql = new StringBuffer();//新建sql查询语句
		List<Integer> typeList = new ArrayList<Integer>();//executeDataset参数
		List<Object> argsList = new ArrayList<Object>();//executeDataset参数
		String batchDetailId = (String)pset.getParameter("batchDetailId");//必须查询条件：批次明细ID（外键）
		String cx_checkOrganName = (String) pset.getParameter("cx_checkOrganName");//查询条件：乡镇（街道）
		String cx_villiageCode = (String) pset.getParameter("cx_villiageCode");//查询条件：行政村区划
		String cx_name = (String) pset.getParameter("cx_name");//查询条件：户主姓名
		String cx_deadName = (String) pset.getParameter("cx_deadName");//查询条件:死者姓名
		sql.append(" select info.INFO_ID,info.BATCH_DETAIL_ID,info.RECORD_ID,info.FILL_TYPE,info.RELIEF_TYPE,info.REQUIRED_FOR_FOOD,info.REQUIRED_FOR_CLOTHES,info.REQUIRED_FOR_HEAT, ");
		sql.append(" info.REQUIRED_FOR_DISEASE,info.REQUIRED_FOR_OTHERS,info.DAMAGE_TIME,info.DISASTER_TYPE,info.COLLAPSED_HOUSE,info.SERIOUS_DAMAGE_HOUSE,info.GENERAL_DAMAGE_HOUSE, ");
		sql.append(" info.REBUILD_HOUSE,info.REPAIRED_HOUSE,info.DEAD_NAME,info.DEAD_SEX,info.DEAD_AGE,info.DEAD_FOLK,info.DEAD_POPULACE,info.DEAD_MISSING_PLACE,info.DEAD_MISSING_TIME, ");
		sql.append(" info.DEAD_MISSING_REASON,info.APPROVAL_FAMILY_NUM,info.APPROVAL_TIMES,info.APPROVAL_FOOD,info.APPROVAL_CLOTHES,info.APPROVAL_REBUILED_HOUSE,info.APPROVAL_REPAIRED_HOUSE, ");
		sql.append(" info.APPROVAL_MONRY,info.ALLOCATION_TYPE,info.BANK,info.BANK_ADDS,info.ACCOUNT_CODE,info.ACCEPT_PEOPLE_NAME,info.ACCEPT_DATE,info.ACCEPT_AREA_CODE, ");
		sql.append(" info.ACCEPT_AREA_NAME,info.CHECK_ORGAN_NAME,info.CHECK_ORGAN_CODE,info.CHECK_PEOPLE_NAME,info.CHECK_DATE,info.AUDIT_ORGAN_NAME,info.AUDIT_ORGAN_CODE, ");
		sql.append(" info.AUDIT_PEOPLE_NAME,info.AUDIT_DATE,info.GRANT_ORGAN_NAME,info.GRANT_ORGAN_CODE,info.GRANT_PEOPLE_NAME,info.GRANT_TIME,info.ORGAN_CODE, ");
		sql.append(" info.ORGAN_NAME,info.FILL_TIME,info.NOTE,info.WORKFLOW_STATUS,family.organ_code as family_organ_code,family.organ_name as family_organ_name,family.town_code,family.villiage_code, ");
		sql.append(" family.name,family.id_card,family.family_num,family.family_type, ");
		sql.append(" family.family_register,family.house_count,family.house_structure ");
		sql.append(" from dis_base_family_record family,dis_relief_info info ");
		sql.append(" where info.record_id=family.record_id ");
		if(StringUtils.isNotEmpty(batchDetailId)){
			sql.append(" and info.batch_detail_id = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(batchDetailId);
		}
		if(StringUtils.isNotEmpty(cx_checkOrganName)){
			sql.append(" and info.check_organ_name like ? ");
			cx_checkOrganName=StringUtils.leftPad(cx_checkOrganName, cx_checkOrganName.length()+1, "%");//左边补一个%
			cx_checkOrganName=StringUtils.rightPad(cx_checkOrganName, cx_checkOrganName.length()+1, "%");//右边补一个%
			typeList.add(Types.VARCHAR);
			argsList.add(cx_checkOrganName);
		}
		if(StringUtils.isNotEmpty(cx_villiageCode)){
			sql.append(" and family.villiage_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cx_villiageCode);
		}
		if(StringUtils.isNotEmpty(cx_name)){
			sql.append(" and family.name like ? ");
			cx_name=StringUtils.leftPad(cx_name, cx_name.length()+1, "%");//左边补一个%
			cx_name=StringUtils.rightPad(cx_name, cx_name.length()+1, "%");//右边补一个%
			typeList.add(Types.VARCHAR);
			argsList.add(cx_name);
		}
		if(StringUtils.isNotEmpty(cx_deadName)){
			sql.append(" and info.dead_name like ? ");
			cx_deadName=StringUtils.leftPad(cx_deadName, cx_deadName.length()+1, "%");//左边补一个%
			cx_deadName=StringUtils.rightPad(cx_deadName, cx_deadName.length()+1, "%");//右边补一个%
			typeList.add(Types.VARCHAR);
			argsList.add(cx_deadName);
		}
		int[] types = new int[typeList.size()];//参数设置
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();//参数设置
		String ifAll = (String) pset.getParameter("ifAll");
		DataSet dSet = new DataSet();
		if(!StringUtils.isNotEmpty(ifAll)){
			dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);//分页
		}else{
			dSet = executeDataset(sql.toString(), types, args, false);
		}
		return dSet;
	}
}