package com.inspur.cams.drel.mbalance.dao.jdbc;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalClinicSpDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalClinicSp;

/**
 * @title:SamMedicalClinicSpDao
 * @description:
 * @author:
 * @since:2011-07-20
 * @version:1.0
*/
 public class SamMedicalClinicSpDao extends EntityDao<SamMedicalClinicSp> implements ISamMedicalClinicSpDao{

 	public SamMedicalClinicSpDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamMedicalClinicSp.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamMedicalClinicSp");
	}

	public void deleteByIds(String[] ids) {
		String[] sql=new String[ids.length];
		for(int i=0;i<ids.length;i++){
			 sql[i]="delete from SAM_MEDICAL_CLINIC_SP where ID='"+ids[i]+"'";
			
		}
		batchUpdate(sql);
		
	}
	
	public void submitRule(String[] ids) {
		String[] sql=new String[ids.length];
		for(int i=0;i<ids.length;i++){
			sql[i]="UPDATE SAM_MEDICAL_CLINIC_SP SET SIGN='1' where ID='"+ids[i]+"'";
			
		}
		batchUpdate(sql);	
	}
	/**
	 * 关联查询
	 */
	public DataSet queryBySql(ParameterSet pset) {
		StringBuffer sql=new StringBuffer(
		"SELECT m.ID AS ID,m.PEOPLE_ID AS PEOPLE_ID,m.HOSPITAL_ID AS HOSPITAL_ID,m.DATE_BEGIN AS DATE_BEGIN,m.DATE_END AS DATE_END,m.TOTAL_EXPENSE AS TOTAL_EXPENSE,m.HOSPITAL_PAY AS HOSPITAL_PAY,m.SPECIAL_PAY AS SPECIAL_PAY,m.SPECIAL_PER AS SPECIAL_PER,m.PERSONAL_PAY AS PERSONAL_PAY,m.NUM AS NUM,m.HOSPITAL_AREA,m.ASSITANCE_TYPE,"+
		"m.DOCTOR AS DOCTOR,m.DIAGNOSIS AS DIAGNOSIS,m.REG_ID AS REG_ID,m.REG_PEOPLE AS REG_PEOPLE,m.REG_TIME AS REG_TIME,b.NAME AS NAME,b.ID_CARD AS ID_CARD,decode(b.SEX,'1','男','2','女') SEX,"+
		"decode(m.SIGN,'0','未提交','1','已提交') SIGN,"+
		"RTRIM("+
		"decode(b.DISABILITY_LEVEL_CODE,'01','一级',"+
                                "'02','二级',"+
                                "'03','三级',"+
                                "'04','四级',"+
                                "'05','五级',"+
                                "'06','六级',"+
                                "'07','七级',"+
                                "'08','八级',"+
                                "'09','九级',"+
                                "'10','十级'," +
                                "null,'')||"+
       "decode(b.DISABILITY_FLAG,'1','伤残人员、','0','', null,'')||"+
       "decode(b.REDA_FLAG,'1','三红人员、','0','',null,'')||"+
       "decode(b.DEPENDANT_FLAG,'1','遗属人员、','0','', null,'')||"+
       "decode(b.DEMOBILIZED_FLAG,'1','在乡复员军人、','0','', null,'')||"+
       "decode(b.WAR_FLAG,'1','参战参试人员、', '0','', null,''),'、') BPT_TYPE,"+
       "getAge(b.BIRTHDAY) AGE "+  
       "FROM SAM_MEDICAL_CLINIC_SP m join BASEINFO_PEOPLE b on m.PEOPLE_ID=b.PEOPLE_ID  where 1=1 ");
		String hospitalId=(String)pset.get("hospitalId");
		String id=(String)pset.get("id");
		String name=(String)pset.get("name");
		String idCard=(String)pset.get("idCard");
		String dateBegin=(String)pset.get("dateBegin");
		String dateEnd=(String)pset.get("dateEnd");
		String hospitalArea=(String)pset.get("hospitalArea");
		String sign=(String)pset.get("sign");
		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append(" AND m.HOSPITAL_ID='"+hospitalId+"' ");
		}
		if(StringUtils.isNotEmpty(id)){
			sql.append(" AND m.ID='"+id+"' ");
		}
		if(StringUtils.isNotEmpty(name)){
			sql.append(" AND b.NAME='"+name+"' ");
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" And b.ID_CARD='"+idCard+"' ");
		}
		String beginTime =(String) pset.getParameter("beginTime");
		if(StringUtils.isNotEmpty(beginTime)){
			sql.append(" AND m.DATE_END >='"+beginTime+"'");
		}
		String endTime =(String) pset.getParameter("endTime");
		if(StringUtils.isNotEmpty(endTime)){
			sql.append(" AND m.DATE_END <='"+endTime+"'");
		}
		if(StringUtils.isNotEmpty(dateBegin)){
			sql.append(" And m.DATE_BEGIN >='"+dateBegin+"'");
		}
		if(StringUtils.isNotEmpty(dateEnd)){
			sql.append(" AND m.DATE_END <='"+dateEnd+"'");
		}
		if(StringUtils.isNotEmpty(hospitalArea)){
			sql.append(" AND m.hospital_Area like '"+hospitalArea.substring(0,hospitalArea.indexOf("000"))+"%' ");
		}
		if(StringUtils.isNotEmpty(sign)){
			sql.append(" AND m.sign = '"+sign+"' ");
		}
		String assitanceType=(String)pset.get("assitanceType");
		if(StringUtils.isNotEmpty(assitanceType)){
			sql.append(" AND m.ASSITANCE_TYPE  in ('"+assitanceType+"') ");
		}
		return executeDataset(sql.toString(), pset.getPageStart(),pset.getPageLimit(), true);
	}
	
	/**
	 * 优抚门规汇总查询
	 * @param pset
	 * @return
	 */
	public DataSet queryForClinic(ParameterSet pset){
		StringBuffer sql=new StringBuffer();
		sql.append(" select sum(a.total_expense) sumtotal,    \n ");
		sql.append("        sum(a.hospital_pay)sumhos,    \n ");
		sql.append("        sum(a.special_pay) sumspec,   \n ");
		sql.append("        sum(a.personal_pay)sumpsn,   \n ");
		sql.append("        sum(a.num) sumnum,     \n ");
		sql.append("        b.organ_name,a.hospital_id    \n ");
		sql.append("   from sam_medical_clinic_sp a, com_ext_organ b    \n ");
		sql.append("   where a.hospital_id = b.organ_id   \n ");
		sql.append(" AND a.sign = '1'  \n");
		String beginTime =(String) pset.getParameter("beginTime");
		if(StringUtils.isNotEmpty(beginTime)){
			sql.append(" AND a.DATE_BEGIN >='"+beginTime+"'");
		}
		String endTime =(String) pset.getParameter("endTime");
		if(StringUtils.isNotEmpty(endTime)){
			sql.append(" AND a.DATE_END <='"+endTime+"'");
		}
		String hospitalArea=(String)pset.get("hospitalArea");
		if(StringUtils.isNotEmpty(hospitalArea)){
			sql.append(" AND a.hospital_Area like '"+hospitalArea.substring(0,hospitalArea.indexOf("000"))+"%' ");
		}
		String hospitalId=(String)pset.get("hospitalId");
		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append(" AND a.HOSPITAL_ID='"+hospitalId+"' ");
		}
		String assitanceType=(String)pset.get("assitanceType");
		if(StringUtils.isNotEmpty(assitanceType)){
			sql.append(" AND a.ASSITANCE_TYPE  in ('"+assitanceType+"') ");
		}
		sql.append("  group by b.organ_name,a.hospital_id    \n ");
		return executeDataset(sql.toString(), pset.getPageStart(),pset.getPageLimit(), true);
	}
	/**
	 * 普通门规录入时人员查询
	 * @param pset
	 * @return
	 */
	
	public DataSet QueryPeople(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		sql.append("   select a.*,b.assistance_type,b.card_no    \n");
		sql.append("    from baseinfo_people a ,sam_family_assistance b \n");
		sql.append("    where a.family_id=b.family_id \n");
		sql.append("    and b.assistance_type in ('01','','02','03','11')  \n");
		
		String idCard = (String)pset.getParameter("idCard");
		String name = (String)pset.getParameter("name");
		String assitanceType = (String)pset.getParameter("assitanceType");
		String cardNo =(String)pset.getParameter("cardNo");
		

		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" AND a.ID_CARD='"+idCard+"' ");
		}
		if(StringUtils.isNotEmpty(name)){
			sql.append(" AND a.NAME='"+name+"' ");
		}
		if(StringUtils.isNotEmpty(assitanceType)){
			sql.append(" AND b.ASSISTANCE_TYPE='"+assitanceType+"' ");
		}
		if(StringUtils.isNotEmpty(cardNo)){
			sql.append(" AND b.CARD_NO='"+cardNo+"' ");
		}
		return executeDataset(sql.toString(), pset.getPageStart(),pset.getPageLimit(), true);
	}
	
	/**
	 * 普通门规查询(列表显示)
	 * @param pset
	 * @return
	 */
	
	public DataSet queryForNomClinic(ParameterSet pset){
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT a.*,b.NAME,b.ID_CARD ,b.SEX,getAge(b.BIRTHDAY) AGE    \n");
		sql.append("   FROM SAM_MEDICAL_CLINIC_SP a,BASEINFO_PEOPLE b     \n");
		sql.append("  WHERE a.PEOPLE_ID=b.PEOPLE_ID    \n");
		sql.append("  AND a.ASSITANCE_TYPE in ('01','02','03','11')  \n");

		String name=(String)pset.get("name");
		String idCard=(String)pset.get("idCard");
		String dateBegin=(String)pset.get("dateBegin");
		String dateEnd=(String)pset.get("dateEnd");
		String id=(String)pset.get("id");
		String hospitalId=(String)pset.get("hospitalId");
		

		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append(" AND a.HOSPITAL_ID='"+hospitalId+"' ");
		}
		if(StringUtils.isNotEmpty(id)){
			sql.append(" AND a.ID='"+id+"' ");
		}
		if(StringUtils.isNotEmpty(name)){
			sql.append(" AND b.NAME='"+name+"' ");
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" AND b.ID_CARD='"+idCard+"' ");
		}
		if(StringUtils.isNotEmpty(dateBegin)){
			sql.append(" AND a.DATE_BEGIN >='"+dateBegin+"'");
		}
		if(StringUtils.isNotEmpty(dateEnd)){
			sql.append(" AND a.DATE_END <='"+dateEnd+"'");
		}
		return executeDataset(sql.toString(), pset.getPageStart(),pset.getPageLimit(), true);
	}
   	/**
   	 * 优抚门规明细查询
   	 * @param pset
   	 * @return
   	 */
	public DataSet queryForClinicDetail(ParameterSet pset){
		StringBuffer sql=new StringBuffer();
		sql.append("   select a.*,b.name,b.id_card  \n");
		sql.append("   	from sam_medical_clinic_sp a, baseinfo_people b\n");
		sql.append("    where a.people_id = b.people_id \n");
		String hospitalId=(String)pset.get("hospitalId");
		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append(" AND a.HOSPITAL_ID='"+hospitalId+"' ");
		}
		String endTime =(String) pset.getParameter("endTime");
		if(StringUtils.isNotEmpty(endTime)){
			sql.append(" AND a.DATE_END <='"+endTime+"'");
		}
		String hospitalArea=(String)pset.get("hospitalArea");
		if(StringUtils.isNotEmpty(hospitalArea)){
			sql.append(" AND a.hospital_Area like '"+hospitalArea.substring(0,hospitalArea.indexOf("000"))+"%' ");
		}
		return executeDataset(sql.toString(), pset.getPageStart(),pset.getPageLimit(), true);
	}
}
