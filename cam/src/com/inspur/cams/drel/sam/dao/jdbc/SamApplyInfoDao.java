package com.inspur.cams.drel.sam.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.bsp.util.StringUtil;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.poi.util.SystemOutLogger;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.drel.sam.dao.ISamApplyInfoDao;
import com.inspur.cams.drel.sam.data.SamApplyInfo;

/**
 * @title:申请审批信息dao
 * @description:
 * @author:	yanliangliang
 * @since:2012-05-02
 * @version:1.0
*/
 public class SamApplyInfoDao extends EntityDao<SamApplyInfo> implements ISamApplyInfoDao{

 	public SamApplyInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

	@SuppressWarnings("unchecked")
	public Class getEntityClass() {
		return SamApplyInfo.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamApplyInfo");
	}
   /**
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @param mysetwhere 自定义查询条件 形式如：String:value&String:value 日期区间为：String:value-value
	 * @return
	 */
   @SuppressWarnings("unchecked")
   public  DataSet queryDaiBan(ParameterSet pset){
	 String procTypeId=(String)pset.getParameter("processType");
	 String actDefName=(String)pset.getParameter("actDefName");
	 String organId=BspUtil.getEmpOrgan().getOrganId();
	 String mysetwhere=(String)pset.getParameter("mysetwhere");
	 String changeItem=(String)pset.getParameter("changeItem");
	 String applyType=(String)pset.getParameter("applyType");
	 StringBuffer sql = new StringBuffer();
//	 sql.append("SELECT w.*,t.*  ,get_city_name(substr(t.domicile_code,0,9)||'000') TOWM_NAME  from  wf_dai_ban_task w , sam_apply_info t  where w.primary_key= t.apply_id  and w.is_visible='1'");
	 sql.append("SELECT t.apply_id,c.ensure_id,w.*,t.family_name,t.domicile_name,t.family_card_no,t.accept_date,get_city_name(substr(t.domicile_code,0,9)||'000') TOWM_NAME ,f.family_phone,f.address,f.family_mobile,f.year_income,f.month_income "+
				" from  wf_dai_ban_task w , sam_apply_info t, (select family_id,family_name,family_phone,family_mobile,address,people_num,assistance_people_num,month_income,year_income from baseinfo_family) f, ensure_to_client c " +
				" where  t.family_id=f.family_id  and c.apply_id(+)=t.apply_id  and w.primary_key= t.apply_id  and w.is_visible='1'");
	 sql.append(" and  w.organ_id =? and w.process_type = ? and w.act_Def_Name = ? ");
	 List typeList = new ArrayList();
	 List argsList = new ArrayList();
	 typeList.add(Types.VARCHAR);
	 argsList.add(organId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(procTypeId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(actDefName);
	 if(StringUtils.isNotEmpty(applyType)){
		 sql.append(" and t.APPLY_TYPE =  ?");
		 typeList.add(Types.VARCHAR);
		 argsList.add(applyType);
	 }
	 //拆分自定义查询字段
	 if(mysetwhere !=null ){
		 String[] mysetwheres=mysetwhere.split("&");
		 for(int i=0;i<mysetwheres.length;i++){
			 String queryString=mysetwheres[i];
			 String[] queryStrings=queryString.split(":");
			 if(queryStrings.length == 2){
				 if("APPLY_DATE".equals(queryStrings[0])){
					 if(queryStrings[1].length()>11){
						 sql.append(" and t.APPLY_DATE between ? and  ?");
						 typeList.add(Types.VARCHAR);
						 argsList.add(queryStrings[1].substring(0,10));
						 typeList.add(Types.VARCHAR);
						 argsList.add(queryStrings[1].substring(11,21));
					 }else if(queryStrings[1].length()>2){
						 if("-".equals(queryStrings[1].charAt(0))){
							 sql.append(" and t.APPLY_DATE < ? ");
							 typeList.add(Types.VARCHAR);
							 argsList.add(queryStrings[1].substring(1,11));
						 }else{
							 sql.append(" and t.APPLY_DATE > ? ");
							 typeList.add(Types.VARCHAR);
							 argsList.add(queryStrings[1].substring(0,10));
						 }
					 }
					 
				 }else if("DOMICILE_CODE".equals(queryStrings[0])){
					 sql.append(" and t."+queryStrings[0]+"  like ?");
					 typeList.add(Types.VARCHAR);
					 argsList.add(toParseOrganCode(queryStrings[1])+"%");
				 }else{
					 sql.append(" and t."+queryStrings[0]+"  like ?");
					 typeList.add(Types.VARCHAR);
					 argsList.add("%"+queryStrings[1]+"%");
				 }
			 }
		 }	
	 }
		if(StringUtils.isNotEmpty(changeItem)){
			sql.append("    AND T.CHANGE_ITEM = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(changeItem);
		}
	 if(pset.getSortField() != null && !"null".equals(pset.getSortField())){
		 sql.append(" order by ");
		 sql.append(pset.getSortField()+" ");
		 sql.append(pset.getSortDir());
	 }else{
		 sql.append(" order by  t.APPLY_DATE");
	 }
	
	 int[] types = new int[typeList.size()];
	 for (int i = 0; i < typeList.size(); i++) {
		types[i] = (Integer) (typeList.get(i));
	 }
	 Object[] args = argsList.toArray(new Object[argsList.size()]);
	 if(pset.getPageStart()>-1 && pset.getPageLimit()>0){
	     return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	 }else{
	     return this.executeDataset(sql.toString(), types, args, true);
	 }
   }
   
   
   /**
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @param mysetwhere 自定义查询条件 形式如：String:value&String:value 日期区间为：String:value-value
	 * @return
	 */
  @SuppressWarnings("unchecked")
  public  DataSet queryDaiBanAndEnsure(ParameterSet pset){
	 String procTypeId=(String)pset.getParameter("processType");
	 String actDefName=(String)pset.getParameter("actDefName");
	 String organId=BspUtil.getEmpOrgan().getOrganId();
	 String mysetwhere=(String)pset.getParameter("mysetwhere");
	 String changeItem=(String)pset.getParameter("changeItem");
	 String applyType=(String)pset.getParameter("applyType");
	 StringBuffer sql = new StringBuffer();
//	 sql.append("SELECT w.*,t.*  ,get_city_name(substr(t.domicile_code,0,9)||'000') TOWM_NAME  from  wf_dai_ban_task w , sam_apply_info t  where w.primary_key= t.apply_id  and w.is_visible='1'");
	 sql.append("SELECT t.CUR_ACTIVITY_ID,t.APPLY_DATE,t.apply_id,c.ensure_id,c.current_status,w.*,t.family_name,t.domicile_name,t.family_card_no,t.accept_date,get_city_name(substr(t.domicile_code,0,9)||'000') TOWM_NAME ,f.family_phone,f.address,f.family_mobile,f.year_income,f.month_income "+
				" from  wf_dai_ban_task w , sam_apply_info t, (select family_id,family_name,family_phone,family_mobile,address,people_num,assistance_people_num,month_income,year_income from baseinfo_family) f, ensure_to_client c " +
				" where  t.family_id=f.family_id  and c.apply_id(+)=t.apply_id  and w.primary_key= t.apply_id  and w.is_visible='1'");
	 sql.append(" and  w.organ_id =? and w.process_type = ? and w.act_Def_Name = ? ");
	 List typeList = new ArrayList();
	 List argsList = new ArrayList();
	 typeList.add(Types.VARCHAR);
	 argsList.add(organId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(procTypeId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(actDefName);
	 if(StringUtils.isNotEmpty(applyType)){
		 sql.append(" and t.APPLY_TYPE =  ?");
		 typeList.add(Types.VARCHAR);
		 argsList.add(applyType);
	 }
	 //拆分自定义查询字段
	 if(mysetwhere !=null ){
		 String[] mysetwheres=mysetwhere.split("&");
		 for(int i=0;i<mysetwheres.length;i++){
			 String queryString=mysetwheres[i];
			 String[] queryStrings=queryString.split(":");
			 if(queryStrings.length == 2){
				 if("APPLY_DATE".equals(queryStrings[0])){
					 if(queryStrings[1].length()>11){
						 sql.append(" and t.APPLY_DATE between ? and  ?");
						 typeList.add(Types.VARCHAR);
						 argsList.add(queryStrings[1].substring(0,10));
						 typeList.add(Types.VARCHAR);
						 argsList.add(queryStrings[1].substring(11,21));
					 }else if(queryStrings[1].length()>2){
						 if("-".equals(queryStrings[1].charAt(0))){
							 sql.append(" and t.APPLY_DATE < ? ");
							 typeList.add(Types.VARCHAR);
							 argsList.add(queryStrings[1].substring(1,11));
						 }else{
							 sql.append(" and t.APPLY_DATE > ? ");
							 typeList.add(Types.VARCHAR);
							 argsList.add(queryStrings[1].substring(0,10));
						 }
					 }
					 
				 }else if("DOMICILE_CODE".equals(queryStrings[0])){
					 sql.append(" and t."+queryStrings[0]+"  like ?");
					 typeList.add(Types.VARCHAR);
					 argsList.add(toParseOrganCode(queryStrings[1])+"%");
				 }else{
					 sql.append(" and t."+queryStrings[0]+"  like ?");
					 typeList.add(Types.VARCHAR);
					 argsList.add("%"+queryStrings[1]+"%");
				 }
			 }
		 }	
	 }
		if(StringUtils.isNotEmpty(changeItem)){
			sql.append("    AND T.CHANGE_ITEM = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(changeItem);
		}
	 if(pset.getSortField() != null && !"null".equals(pset.getSortField())){
		 sql.append(" order by ");
		 sql.append(pset.getSortField()+" ");
		 sql.append(pset.getSortDir());
	 }else{
		 sql.append(" order by  CURRENT_STATUS DESC,t.APPLY_DATE ");
	 }
	
	 int[] types = new int[typeList.size()];
	 for (int i = 0; i < typeList.size(); i++) {
		types[i] = (Integer) (typeList.get(i));
	 }
	 Object[] args = argsList.toArray(new Object[argsList.size()]);
	 if(pset.getPageStart()>-1 && pset.getPageLimit()>0){
	     return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	 }else{
	     return this.executeDataset(sql.toString(), types, args, true);
	 }
  }
   
   @SuppressWarnings("unchecked")
   public  DataSet queryForPeopleDetail(ParameterSet pset){
   		String domicileCode=(String)pset.getParameter("domicileCode");
   		String applyType=(String)pset.getParameter("applyType");
   		String townName=(String)pset.getParameter("townName");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 System.out.println(domicileCode);
		 System.out.println(applyType);
		 sql.append("select t.CUR_ACTIVITY_NAME, t.domicile_name,c.name as town_name,t.apply_id,t.family_name,t.family_card_no,p.name,p.id_card,p.birthday,p.sex,p.relationship_type from sam_apply_info t  ");
		 sql.append(" left join BASEINFO_PEOPLE p on p.family_id = t.family_id  ");
		 sql.append(" left join dic_city c   on c.id = rpad(substr(t.domicile_code, 0, 9), 12, '0')");
		 sql.append("   where  t.is_finish = '0' and t.cur_activity_id = 'check' and t.apply_type in ('010','020','030') and p.people_id is not null");
		 
		 if(StringUtils.isNotEmpty(domicileCode)){
			 sql.append("   and t.domicile_code like  ?" );
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode+"%");
		 }
		 if(StringUtils.isNotEmpty(applyType)){
			 sql.append("   and t.apply_type =  ?" );
				typeList.add(Types.VARCHAR);
				argsList.add(applyType);
		 }
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 if(pset.getPageStart()>=0 && pset.getPageLimit()>0){
			 return this.executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), true);
		 }else{
			 return this.executeDataset(sql.toString(), types, args, true);
		 }
		 
   }
   @SuppressWarnings("unchecked")
   public  DataSet queryForExportPeople(ParameterSet pset){
//	   String applyId=(String)pset.getParameter("applyIds");
//		 String[] applyIds = (String[]) applyId.split(","); 
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select count(p.people_id) peo_num,c.name TOWM_NAME, rpad(substr(t.domicile_code, 0, 6), 12, '0') domicile_code,t.apply_type from sam_apply_info t  ");
		 sql.append(" left join dic_city c   on c.id = rpad(substr(t.domicile_code, 0, 6), 12, '0')");
		 sql.append(" left join BASEINFO_PEOPLE p on p.family_id = t.family_id");
		 sql.append("   where  t.is_finish = '0' and t.cur_activity_id = 'check' and t.apply_type in ('010','020','030') and p.people_id is not null  ");
		 sql.append("   group by c.name,apply_type, rpad(substr(t.domicile_code, 0, 6), 12, '0') ");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		 
   }
   
   @SuppressWarnings("unchecked")
   public  DataSet queryInTheWarranty(ParameterSet pset){
//	   String applyId=(String)pset.getParameter("applyIds");
//		 String[] applyIds = (String[]) applyId.split(","); 
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select count(p.p.people_id) peo_num,c.name TOWM_NAME, rpad(substr(t.domicile_code, 0, 6), 12, '0') domicile_code,t.assistance_type apply_type from sam_family_treatment t left join baseinfo_people p on t.family_id = p.family_id  ");
		 sql.append(" left join dic_city c   on c.id = rpad(substr(t.domicile_code, 0, 6), 12, '0')");
		 sql.append("   where to_char(sysdate,'yyyy-MM-dd') between t.begin_date and t.end_date ");
		 sql.append("   group by c.name,assistance_type, rpad(substr(t.domicile_code, 0, 6), 12, '0') ");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		 
   }
   
   
   
   
   /**
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @param mysetwhere 自定义查询条件 形式如：String:value&String:value 日期区间为：String:value-value
	 * @return
	 */
  @SuppressWarnings("unchecked")
  public  DataSet queryExport(ParameterSet pset){
	 String applyId=(String)pset.getParameter("applyIds");
	 String[] applyIds = (String[]) applyId.split(","); 
	 List typeList = new ArrayList();
	 List argsList = new ArrayList();
	 StringBuffer sql = new StringBuffer();
	 sql.append("select t.apply_id,t.family_name,t.family_card_no,p.name,p.id_card,p.birthday,p.sex,p.relationship_type from sam_apply_info t  ");
	 sql.append(" left join BASEINFO_PEOPLE p on p.family_id = t.family_id  where");
	 
		 for(int i=0;i<applyIds.length;i++){
			 if(i==0){
				 sql.append(" t.apply_id = ? ");
				 typeList.add(Types.VARCHAR);
				argsList.add(applyIds[i]);
			 }else{
				 sql.append(" or t.apply_id = ?  ");
				 typeList.add(Types.VARCHAR);
				argsList.add(applyIds[i]);
			 }
			
			
		}
	
	 int[] types = new int[typeList.size()];
	 for (int i = 0; i < typeList.size(); i++) {
		types[i] = (Integer) (typeList.get(i));
	 }
	 Object[] args = argsList.toArray(new Object[argsList.size()]);
	 return this.executeDataset(sql.toString(), types, args, true);
  }

	/**
	 * 更新照片
	 * @param photoId 原来的ID
	 * @param photoText 新的照片
	 * @return 新的ID
	 */
	public String updatePhoto(String photoId, String photoText) {
		if(photoId!=null && !("".equals(photoId.trim())) && photoText!=null && !("".equals(photoText.trim()))){
			//删除原照片
			StringBuffer querySql = new StringBuffer();
			String tableName = "COM_PHOTO_"+photoId.substring(0,6);
			querySql.append("delete from ").append(tableName).append(" where PHOTO_ID=?");
			this.executeUpdate(querySql.toString(), new int[]{Types.VARCHAR}, new Object[]{photoId});
			//保存新照片
			String newPhotoId = PhotoUtil.savePhoto(photoText);
			return newPhotoId;
		}
		return photoId;
	}
	 /**
	  * 查询已办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @param mysetwhere 自定义查询条件 形式如：String:value&String:value 日期区间为：String:value-value
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryYiBan(ParameterSet pset) {
		 String procTypeId=(String)pset.getParameter("processType");
		 String actDefName=(String)pset.getParameter("actDefName");
		 String organId=BspUtil.getEmpOrgan().getOrganId();
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT w.*,t.* ,get_city_name(substr(t.domicile_code,0,9)||'000') TOWM_NAME  from  sam_apply_info t , wf_yi_ban_task w ,(SELECT m.PRIMARY_KEY, MAX(m.END_TIME) END_TIME  FROM WF_YI_BAN_TASK m    WHERE m.ORGAN_ID = ? and m.process_Type=? and m.act_Def_Name = ?  GROUP BY m.PRIMARY_KEY) M  where t.apply_id=w.primary_key AND w.end_time = M.end_time and t.is_finish='0'");
		 sql.append(" and  w.organ_id =? and w.process_type = ? and w.act_Def_Name = ?");
		 sql.append(" and w.primary_key=M.primary_key ");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(actDefName);
		 
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(actDefName);
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 String[] mysetwheres=mysetwhere.split("&");
			 for(int i=0;i<mysetwheres.length;i++){
				 String queryString=mysetwheres[i];
				 String[] queryStrings=queryString.split(":");
				 if(queryStrings.length == 2){
					 if("APPLY_DATE".equals(queryStrings[0])){
						 if(queryStrings[1].length()>11){
							 sql.append(" and t.APPLY_DATE between ? and  ?");
							 typeList.add(Types.VARCHAR);
							 argsList.add(queryStrings[1].substring(0,10));
							 typeList.add(Types.VARCHAR);
							 argsList.add(queryStrings[1].substring(11,21));
						 }else if(queryStrings[1].length()>2){
							 if("-".equals(queryStrings[1].charAt(0))){
								 sql.append(" and t.APPLY_DATE < ? ");
								 typeList.add(Types.VARCHAR);
								 argsList.add(queryStrings[1].substring(1,11));
							 }else{
								 sql.append(" and t.APPLY_DATE > ? ");
								 typeList.add(Types.VARCHAR);
								 argsList.add(queryStrings[1].substring(0,10));
							 }
						 }
						 
					 }else if("DOMICILE_CODE".equals(queryStrings[0])){
						 sql.append(" and t."+queryStrings[0]+"  like ?");
						 typeList.add(Types.VARCHAR);
						 argsList.add(toParseOrganCode(queryStrings[1])+"%");
					 }else{
						 sql.append(" and t."+queryStrings[0]+" like ?");
						 typeList.add(Types.VARCHAR);
						 argsList.add("%"+queryStrings[1]+"%");
					 }
				 }
			 }
		 }
		 sql.append(" order by w.END_TIME DESC");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 
		 if(pset.getPageStart()>=0 && pset.getPageLimit()>0){
		     return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		 }else{
		     return this.executeDataset(sql.toString(), types, args, true);
		 }
		 
	}
	/**
	 * 查询结束任务
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryEnd(ParameterSet pset){
		 StringBuffer sql = new StringBuffer();
		 
		 String applyType=(String)pset.getParameter("applyType");
//		 sql.append("SELECT w.*,t.* ,get_city_name(substr(t.domicile_code,0,9)||'000') TOWM_NAME  from  sam_apply_info t , wf_end_task w , (SELECT m.PRIMARY_KEY, MAX(m.END_TIME) END_TIME  FROM WF_END_TASK m    WHERE m.ORGAN_ID = ? and m.process_Type=? GROUP BY m.PRIMARY_KEY) M   where t.apply_id=w.primary_key AND w.end_time = M.end_time  and t.is_finish='1' ");
	
//		 String procTypeId=(String)pset.getParameter("processType");
//		 String organId=BspUtil.getEmpOrgan().getOrganId();
//		 String mysetwhere=(String)pset.getParameter("mysetwhere");
//		 sql.append(" and  w.organ_id =? and w.process_type = ?");
//		 sql.append(" and w.primary_key=M.primary_key ");
//		 List typeList = new ArrayList();
//		 List argsList = new ArrayList();
//		 typeList.add(Types.VARCHAR);
//		 argsList.add(organId);
//		 typeList.add(Types.VARCHAR);
//		 argsList.add(procTypeId);
//		 typeList.add(Types.VARCHAR);
//		 argsList.add(organId);
//		 typeList.add(Types.VARCHAR);
//		 argsList.add(procTypeId);
		
		 sql.append("SELECT w.*,t.*,get_city_name(substr(t.domicile_code,0,9)||'000') TOWM_NAME from  sam_apply_info t , wf_end_task w , (SELECT m.PRIMARY_KEY, MAX(m.END_TIME) END_TIME  FROM WF_END_TASK m  " +
					"  WHERE m.process_Type=? GROUP BY m.PRIMARY_KEY) M   where t.apply_id=w.primary_key AND w.end_time = M.end_time  " +
					"and t.is_finish='1' ");
		 
//		 sql.append("SELECT w.*,t.*,get_city_name(substr(t.domicile_code,0,9)||'000') TOWM_NAME from  sam_apply_info t , wf_end_task w , (SELECT m.PRIMARY_KEY, MAX(m.END_TIME) END_TIME  FROM WF_END_TASK m  " +
//					"  WHERE m.process_Type=? GROUP BY m.PRIMARY_KEY) M   where t.apply_id=w.primary_key AND w.end_time = M.end_time  " +
//					"and t.is_finish='1' and (t.audit_opinion_id='0' or t.check_opinion_id='0') ");
		 
		 String processTypeRC = (String) pset.getParameter("processTypeRC");
			String processTypeCH = (String) pset.getParameter("processTypeCH");
			String mysetwhere = (String) pset.getParameter("mysetwhere");
			sql.append(" and w.process_type = ?");
			sql.append(" and w.primary_key=M.primary_key ");
			List typeList = new ArrayList();
			List argsList = new ArrayList();

			typeList.add(Types.VARCHAR);
			argsList.add(processTypeRC);

			typeList.add(Types.VARCHAR);
			argsList.add(processTypeRC);

			sql.append(" AND t.FAMILY_ID NOT IN (select distinct(b.family_id) from wf_dai_ban_task a, sam_apply_info b ");
					sql.append(" where b.apply_id=a.primary_key and  a.process_Type=? and b.is_finish !='1')");
			
					typeList.add(Types.VARCHAR);
					argsList.add(processTypeCH);
		 
		 if(StringUtils.isNotEmpty(applyType)){
			 sql.append(" and t.APPLY_TYPE =  ?");
			 typeList.add(Types.VARCHAR);
			 argsList.add(applyType);
		 }
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 String[] mysetwheres=mysetwhere.split("&");
			 for(int i=0;i<mysetwheres.length;i++){
				 String queryString=mysetwheres[i];
				 String[] queryStrings=queryString.split(":");
				 if(queryStrings.length == 2){
					 if("APPLY_DATE".equals(queryStrings[0])){
						 if(queryStrings[1].length()>11){
							 sql.append(" and t.APPLY_DATE between ? and  ?");
							 typeList.add(Types.VARCHAR);
							 argsList.add(queryStrings[1].substring(0,10));
							 typeList.add(Types.VARCHAR);
							 argsList.add(queryStrings[1].substring(11,21));
						 }else if(queryStrings[1].length()>2){
							 if("-".equals(queryStrings[1].charAt(0))){
								 sql.append(" and t.APPLY_DATE < ? ");
								 typeList.add(Types.VARCHAR);
								 argsList.add(queryStrings[1].substring(1,11));
							 }else{
								 sql.append(" and t.APPLY_DATE > ? ");
								 typeList.add(Types.VARCHAR);
								 argsList.add(queryStrings[1].substring(0,10));
							 }
						 }
						 
					 }else if("DOMICILE_CODE".equals(queryStrings[0])){
						 sql.append(" and t."+queryStrings[0]+"  like ?");
						 typeList.add(Types.VARCHAR);
						 argsList.add(toParseOrganCode(queryStrings[1])+"%");
					 }else{
						 sql.append(" and t."+queryStrings[0]+" like ?");
						 typeList.add(Types.VARCHAR);
						 argsList.add("%"+queryStrings[1]+"%");
					 }
				 }
			 }
		 }
		 sql.append(" order by w.END_TIME DESC");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 if(pset.getPageStart()>=0 && pset.getPageLimit()>0){
		     return  this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		 }else{
		     return  this.executeDataset(sql.toString(), types, args, true);
		 }
	}
	/**
	 * 查询历史
	 */
	public DataSet queryHis(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		String familyId=(String)pset.getParameter("familyId");
		//String assistanceType=(String)pset.getParameter("assistanceType");
		sql.append("select a.treatment_id,                           \n");
		sql.append("       a.apply_id,                              \n");
		sql.append("       b.family_id,                              \n");
		sql.append("       b.domicile_name,                          \n");
		sql.append("       b.family_card_no,                         \n");
		sql.append("       b.family_name,                            \n");
		sql.append("       a.assistance_type,                        \n");
		sql.append("       b.assistance_people_num,                  \n");
		sql.append("       a.assistance_money,                       \n");
		sql.append("       b.asisstance_class,                       \n");
		sql.append("       a.assistance_class_money,                 \n");
		sql.append("       a.begin_date,                 			 \n");
		sql.append("       a.end_date,                 			 \n");
		sql.append("       a.adjust_date			                 \n");
		sql.append("  from sam_family_treatment a, sam_apply_info b  \n");
		sql.append(" where a.apply_id = b.apply_id                   \n");
		sql.append("   and b.family_id = ?                     	  \n");
		//sql.append("   and a.assistance_type = ?                     \n");		
		return executeDataset(sql.toString(), new int[]{Types.VARCHAR},new Object[]{familyId},
				pset.getPageStart(), pset.getPageLimit(), true);		
	}
	/**
	 * 解析行政区划
	 * @param string
	 * @return
	 */
	private String toParseOrganCode(String string) {
		if(string.substring(4, 12).equals("00000000")){//市级
			return string.substring(0,4);
		}else if(string.substring(6, 12).equals("000000")){//区县级
			return string.substring(0,6);
		}else if(string.substring(9, 12).equals("000")){//街道
			return string.substring(0,9);
		}
		return string;
	}
	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	public void toDuplicateRecord(SamApplyInfo applyInfo) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_ARCHIVE");
		map.put("parameterNum",	2);
		map.put("parameterName_1", "applyId");
		map.put("parameterName_2", "familyId");
		map.put("parameterValue_1", applyInfo.getApplyId());
		map.put("parameterValue_2", applyInfo.getFamilyId());
		map.put("NumberOfResultSet",0);
		new ProceduresUtil().init(getDataSource(),map).call(map);
	}
	/**
	 * 调用存储过程删除历史采集的信息
	 */
	public void deleteHisInfoByApplyAndFamilyId(String applyId, String familyId){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_DELETE_HIS");
		map.put("parameterNum",	2);
		map.put("parameterName_1", "applyId");
		map.put("parameterName_2", "familyId");
		map.put("parameterValue_1",applyId);
		map.put("parameterValue_2",familyId);
		map.put("NumberOfResultSet",0);
		new ProceduresUtil().init(getDataSource(),map).call(map);
	}
	/**
	 * 根据主键删除业务信息
	 * @param applyId
	 */
	public void deleteSamApply(String applyId) {
		 StringBuffer sql = new StringBuffer();
		 sql.append(" DELETE FROM SAM_APPLY_INFO T WHERE T.APPLY_ID= ? ");
		 int[] types = new int[] { Types.VARCHAR };
		 Object[] args = new Object[] { applyId };
		 executeUpdate(sql.toString(), types, args);
		
	}

	/**
	* @Title: addCheck
	* @Description: TODO(审批时发起核对方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	public void addCheck(ParameterSet set) {
		String applyId=(String)set.getParameter("applyId");
		String familyId=(String)set.getParameter("familyId");
		String checkOrgArea=(String)set.getParameter("checkOrgArea");
		String curActivity=(String)set.getParameter("curActivity");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_ENSUREY_MAKE");
		map.put("parameterNum",	5);
		map.put("parameterName_1", "applyId");
		map.put("parameterName_2", "familyId");
		map.put("parameterName_3", "organId");
		map.put("parameterName_4", "checkOrgArea");
		map.put("parameterName_5", "curActivity");
		map.put("parameterValue_1", applyId);
		map.put("parameterValue_2", familyId);
		map.put("parameterValue_3", BspUtil.getCorpOrgan().getOrganId());
		map.put("parameterValue_4", checkOrgArea);
		map.put("parameterValue_5", curActivity);
		map.put("NumberOfResultSet",0);
		new ProceduresUtil().init(getDataSource(),map).call(map);
		
	}
    /**
     * 复查待办
     **/
	public DataSet queryNoticePrintData(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select a.family_name,                                             \n");
		sql.append("       c.address,                                                  \n");
		sql.append("       c.domicile_name,                                            \n");
		sql.append("       a.people_num,                                               \n");
		sql.append("       a.assistance_people_num,                                    \n");
		sql.append("       b.assistance_money origina_money,                           \n");
		sql.append("       a.assistance_money new_money,                               \n");
		sql.append("       b.support_way      origina_way,                             \n");
		sql.append("       decode(a.change_item,'03','停止供养',a.support_way ) new_way \n");		 
		sql.append("  from sam_apply_info a, sam_family_treatment b,baseinfo_family c  \n");
		sql.append(" where a.family_id = b.family_id                                   \n");
		sql.append("   and a.family_id = c.family_id                                   \n");
		String assistanceDate=(String)pset.getParameter("assistanceDate");
		sql.append("   and b.begin_date <= '"+assistanceDate+"'                        \n");
		sql.append("   and b.end_date >= '"+assistanceDate+"'                          \n");
		String assistanceType=(String)pset.getParameter("assistanceType");
		sql.append("   and b.assistance_type = '"+assistanceType+"'                    \n");
		String applyIds=(String)pset.getParameter("applyIds");
		sql.append("   and a.apply_id in ('"+applyIds.replaceAll(",", "','")+"')       \n");
		return executeDataset(sql.toString(), true);
	}

	public BigDecimal getAssistanceMoney(ParameterSet pset) {
		String assitanceType = (String)pset.getParameter("assitanceType");
		String domicileCode =  BspUtil.getOrganCode().substring(0,6)+"%";
		StringBuffer sql = new StringBuffer();
		sql.append("select low_standards from sam_low_standards t where t.assitance_type = ? " +
				" and t.domicile_code like ? and t.in_use = '1'");
        DataSet ds=executeDataset(sql.toString(), 
        		new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{assitanceType,domicileCode}, true);
        if(ds.getCount() > 0){
        	return (BigDecimal)ds.getRecord(0).get("LOW_STANDARDS");
        }else{
        	return new BigDecimal(0);
        }
	}
	/**
	 * 历史数据删除人员
	 */
	public void deleteHisPeople(String peopleId, String familyId) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_HIS_PEOPLE_DELETE");
		map.put("parameterNum",	2);
		map.put("parameterName_1", "peopleId");
		map.put("parameterName_2", "familyId");
		map.put("parameterValue_1",peopleId);
		map.put("parameterValue_2",familyId);
		map.put("NumberOfResultSet",0);
		new ProceduresUtil().init(getDataSource(),map).call(map);
		
	}

	public void updateCurActId(String struId, String applyId) {
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT * from  wf_dai_ban_task w ");
		 sql.append(" where   w.primary_key = ?");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(applyId);
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 DataSet ds = this.executeDataset(sql.toString(), types, args, true);
		 String curActName="";
		if(ds.getCount()>0 ){
			curActName = (String)ds.getRecord(0).get("ACT_DEF_NAME");
		}
		String actCurId= "";
		if("审批".equals(curActName)){
			actCurId = "audit";
		}else if("审核".equals(curActName)){
			actCurId = "check";
		}else if("受理".equals(curActName)){
			actCurId = "accept";
		}
		 StringBuffer updatesql = new StringBuffer();
		 updatesql.append("UPDATE SAM_APPLY_INFO T SET T.cur_activity_id = '"+actCurId+"' ,t.cur_activity_name = '"+curActName+"' where t.apply_id = ?");
		 int[] types1 = new int[] { Types.VARCHAR };
		 Object[] args1 = new Object[] { applyId };
		 executeUpdate(updatesql.toString(), types1, args1);
	}
	
	
	public void updateFamilyArchive(SamApplyInfo applyInfo) {
		// TODO Auto-generated method stub
		String sql  = "UPDATE BASEINFO_FAMILY_ARCHIVE SET RECHECK_TIME =?,RECHECK_PEOPLE_NAME=?,RECHECK_PEOPLE_ID =?, RECHECK_ORGAN_NAME=?," +
		"RECHECK_ORGAN_ID=?, RECHECK_RESULT =? WHERE FAMILY_CARD_NO = ?";
		List typeList = new ArrayList();
		List argsList = new ArrayList();
		
		typeList.add(Types.VARCHAR);
		argsList.add(DateUtil.getDay());
		
		typeList.add(Types.VARCHAR);
		argsList.add(applyInfo.getAuditPeopleName());
		
		typeList.add(Types.VARCHAR);
		argsList.add(applyInfo.getAuditPeopleId());
		
		typeList.add(Types.VARCHAR);
		argsList.add(applyInfo.getAuditPrincipal());
		
		typeList.add(Types.VARCHAR);
		argsList.add(applyInfo.getAuditDeptId());
		
		typeList.add(Types.VARCHAR);
		argsList.add(applyInfo.getAuditOpinionId());
		
		typeList.add(Types.VARCHAR);
		argsList.add(applyInfo.getFamilyCardNo());
		
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		executeUpdate(sql, types, args);
	}
	
	
	
	public String exportToXml(ParameterSet pset) {
		 String applyId=(String)pset.getParameter("applyIds");
		 String[] applyIds = (String[]) applyId.split(","); 
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select *  from sam_apply_info t ");
		 sql.append(" left join BASEINFO_PEOPLE p on p.family_id = t.family_id left join sam_family_treatment s on s.family_id = t.family_id   where");
		 
			 for(int i=0;i<applyIds.length;i++){
				 if(i==0){
					 sql.append(" t.apply_id = ? ");
					 typeList.add(Types.VARCHAR);
					argsList.add(applyIds[i]);
				 }else{
					 sql.append(" or t.apply_id = ?  ");
					 typeList.add(Types.VARCHAR);
					argsList.add(applyIds[i]);
				 }
				
				
			}
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 DataSet ds =  this.executeDataset(sql.toString(), types, args, true);
		 
		 
		 StringBuffer xml = new StringBuffer();
		 xml.append("<Government><Header>");
		 //头信息
		 xml.append("<D204I000001>00201</D204I000001><D204I000002>110108</D204I000002><D204I000003>110108</D204I000003><D204I000004>110108</D204I000004><D204I000005>110108</D204I000005><D204I000006>110108</D204I000006>");
		 xml.append("</Header><Data>");
		 
		 for(int i=0;i<ds.getCount();i++){
			 //姓名
			 xml.append("<Record><D204A000003>"); xml.append(ds.getRecord(i).get("FAMILY_NAME")); xml.append("</D204A000003>");
			 //证件类型
			 xml.append("<D204A000004>"); xml.append(ds.getRecord(i).get("ID_CARD_TYPE")); xml.append("</D204A000004>");
			 //有效身份证件号码
			 xml.append("<D204A000005>"); xml.append(ds.getRecord(i).get("ID_CARD")); xml.append("</D204A000005>");
			 //出生年月
			 xml.append("<D204A010003>"); xml.append(ds.getRecord(i).get("BIRTHDAY")); xml.append("</D204A010003>");
			 //户籍类型
			 xml.append("<D204A010011>"); xml.append(ds.getRecord(i).get("DOMICILE_TYPE")); xml.append("</D204A010011>");
			 //救助类别
			 xml.append("<D204Z520001>"); xml.append(ds.getRecord(i).get("ASSISTANCE_TYPE")); xml.append("</D204Z520001>");
			//救助证号
			 xml.append("<D204Z520002>"); xml.append(ds.getRecord(i).get("CARD_NO")); xml.append("</D204Z520002>");
			 //月救助金额
			 xml.append("<D204Z520003>"); xml.append(ds.getRecord(i).get("ASSISTANCE_MONEY")); xml.append("</D204Z520003>");
			 //救助开始年月
			 xml.append("<D204Z520004>"); xml.append(ds.getRecord(i).get("BEGIN_DATE")); xml.append("</D204Z520004>");
			 //救助截止年月
			 xml.append("<D204Z520005>"); xml.append(ds.getRecord(i).get("END_DATE")); xml.append("</D204Z520005></Record>");
		 
		 }
		 
		 xml.append("</Data></Government>");
		 
		 return xml.toString();
		 
	}
	
	
	@SuppressWarnings("unchecked")
	  public  DataSet queryInAssitanceDetail(ParameterSet pset){
		 String applyType=(String)pset.getParameter("applyType");
		 String domicileCode=(String)pset.getParameter("domicileCode");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select t.family_id,t.apply_id,p.name FAMILY_NAME,p.id_card FAMILY_CARD_NO,p.id_card_type,bp.name,bp.id_card,bp.birthday,bp.ID_CARD_TYPE,bp.sex,bp.relationship_type from  SAM_FAMILY_TREATMENT t ");
		 sql.append("  left join baseinfo_people p on t.family_id = p.family_id and p.relationship_type = '01' ");
		 sql.append("  left join baseinfo_people bp on p.family_id = bp.family_id ");
		 if(StringUtils.isNotEmpty(applyType)&&StringUtils.isNotEmpty(domicileCode)){
			 sql.append("   where t.apply_id in (select t.apply_id from sam_family_treatment t where to_char(sysdate, 'yyyy-MM-dd') between t.begin_date and t.end_date and t.assistance_type =? and t.domicile_code like ? ) ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyType);
			
			typeList.add(Types.VARCHAR);
			argsList.add(domicileCode+"%");
		 }else{
			 sql.append("   where t.apply_id in (select t.apply_id from sam_family_treatment t where to_char(sysdate, 'yyyy-MM-dd') between t.begin_date and t.end_date ) ");
		 }
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 if(pset.getPageStart()>=0 && pset.getPageLimit()>0){
			 return this.executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), true);
		 }else{
			 return this.executeDataset(sql.toString(), types, args, true);
		 }
	  }
}
