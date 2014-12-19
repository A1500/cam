package com.inspur.cams.drel.ensureInfo.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import org.apache.commons.lang.StringUtils;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.drel.ensureInfo.dao.IEnsureToClientDao;
import com.inspur.cams.drel.ensureInfo.data.EnsureToClient;

/**
 * 核查业务反馈表dao
 * @author 
 * @date 2014-07-23
 */
public class EnsureToClientDao extends EntityDao<EnsureToClient> implements IEnsureToClientDao {
	
	@Override
	public Class<EnsureToClient> getEntityClass() {
		return EnsureToClient.class;
	}
	
	
	//查询核对参考标准
	public DataSet queryInfo(ParameterSet pset){
		 String applyId=(String)pset.getParameter("applyId");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
//		 sql.append("select t.*, f.people_num, s.low_standards,d.family_id is_dead from ensure_to_client t");
//		 sql.append(" left join sam_apply_info i on t.apply_id = i.apply_id left join baseinfo_family f on f.family_id = i.family_id ");
//		 sql.append(" left join SAM_LOW_STANDARDS s  on s.domicile_code = rpad(substr(i.domicile_code,1,6),12,'0') and substr(i.apply_type,1,2)=s.assitance_type  ");
//		 sql.append(" left join (select family_id from FIS_CREMATION_INFO_SUM fs,baseinfo_people t where t.id_card=fs.id_card ) d  on d.family_id = i.family_id where 1=1 ");
//		 
//		 if(StringUtils.isNotEmpty(applyId)){
//			 sql.append(" and t.apply_id = ? ");
//			 typeList.add(Types.VARCHAR);
//			 argsList.add(applyId);
//		 }
		 
		 
		 sql.append("select t.Feedback_Time,AREA_NAME,count(t.COMMISSION_ID) as FAMILY_NUM,'城市低保新增' as apply_type, ");
		 sql.append(" count(p.PEOPLE_ID) as people_num,count(a.d204z57_id) as salary_num,count(b.d204c21_id) as car_num,count(c.d204c22_id) as house_num,count(d.d204d32_id) as insurance_num,count(e.d204d34_id) as fund_num,count(f.d204b12_id) as earning_num  from ensure_to_client t ");
		 sql.append("left join d204a01 p on t.apply_id = p.family_id ");
		 sql.append("left join d204z57 a on a.PEOPLE_ID = p.PEOPLE_ID " ); //财政供养人员工资信息
		 sql.append("left join d204c21 b on b.PEOPLE_ID = p.PEOPLE_ID "); //车辆
		 sql.append("left join d204c22 c on c.PEOPLE_ID = p.PEOPLE_ID ");//房产
		 sql.append("left join d204d32 d on d.PEOPLE_ID = p.PEOPLE_ID ");//社会保险缴费
		 sql.append("left join d204d34 e on e.PEOPLE_ID = p.PEOPLE_ID ");//公积金缴纳情况
		 sql.append("left join d204b12 f on f.PEOPLE_ID = p.PEOPLE_ID ");//经营性收入
		 sql.append("group by AREA_NAME,Feedback_Time ");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 DataSet ds =  this.executeDataset(sql.toString(), types, args, true);
		 
		 
		 String str = "";
		 for(int i=0;i<ds.getCount();i++){
			 if(!"0".equals(ds.getRecord(i).get("salary_num"))){
				 str +="财政供养人员工资信息，";
			 }
			 if(!"0".equals(ds.getRecord(i).get("car_num"))){
				 str +="车辆，";
			 }
			 if(!"0".equals(ds.getRecord(i).get("house_num"))){
				 str +="房产，";
			 }
			 if(!"0".equals(ds.getRecord(i).get("insurance_num"))){
				 str +="社会保险缴费，";
			 }
			 if(!"0".equals(ds.getRecord(i).get("fund_num"))){
				 str +="公积金缴纳情况，";
			 }
			 if(!"0".equals(ds.getRecord(i).get("earning_num"))){
				 str +="经营性收入，";
			 }
			 //财政供养人员工资信息，车辆，房产，社会保险缴费，公积金缴纳情况，经营性收入
			 ds.getRecord(i).set("PROJECT_NAME", str);
		 }
		 return ds;
	}
	
	//核对婚姻信息
	public DataSet queryMarryInfo(ParameterSet pset){
	
		 String familyName=(String)pset.getParameter("familyName");
		 String isMarry=(String)pset.getParameter("isMarry");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select t.family_name, t.family_card_no,p.sex,decode(p.sex,'1',m.name_woman,m.name_man) spouse_name,decode(p.sex,'1',m.cert_num_woman,m.cert_num_man) SPOUSE_ID_CARD,m.dept_name,to_char(m.op_date,'YYYY-MM-DD') register_date,M.OP_TYPE,m.print_remark from baseinfo_family t ");
		 sql.append("left join rc_marry m on t.family_card_no = m.cert_num_man  or t.family_card_no = m.cert_num_woman ");
		 sql.append("left join baseinfo_people p on t.family_card_no = p.id_card");
		 sql.append(" where t.people_num='1' ");
		 
		 
		 if(StringUtils.isNotEmpty(isMarry)){
			 if(isMarry.equals("1")){
				 sql.append(" and m.id is not null ");
			 }else{
				 sql.append(" and m.id is  null ");
			 }
		 }
		 
		 if(StringUtils.isNotEmpty(familyName)){
			 sql.append(" and t.FAMILY_NAME like ? ");
			 typeList.add(Types.VARCHAR);
			 argsList.add(familyName);
		 }
		 
		 
		 sql.append(" order by t.family_name,m.op_date ");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 DataSet ds =  this.executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), true);
		 return ds;
	}
	
	//查询疑似信息
	public DataSet querySuspectInfo(ParameterSet pset){
		String organCode = BspUtil.getOrganCode();
		 StringBuffer sql = new StringBuffer();
		 organCode= getAreaCodeLikePrefix(organCode);
		 if(organCode.length()>9){
			 sql.append("select * from ensure_to_client t ,sam_apply_info s where t.apply_id = s.apply_id and  t.current_status = '1'  and s.domicile_code like '"+organCode+"%'");
		 }else{
			 sql.append("select c.name,t.FEEDBACK_TIME,s.APPLY_TYPE,count(case when t.read_status = '2' then 1 else 0 end) as USE_NUM,count(case when t.read_status = '1' then 1 else 0 end) NOT_USE_NUM from ensure_to_client t ,sam_apply_info s ");
			 sql.append(",dic_city  c");
			 sql.append(" where t.apply_id = s.apply_id and  t.current_status = '1' and s.domicile_code like '"+organCode+"%'");
			 sql.append("  and rpad(substr(s.domicile_code,0,9),12,'0') = c.id ");
			 sql.append(" group by c.name,t.FEEDBACK_TIME,s.APPLY_TYPE");
		 }
		 
//		 System.out.println(sql.toString());
		 
		 DataSet ds =  this.executeDataset(sql.toString(),true);
		 return ds;
	}
	
	private String getAreaCodeLikePrefix(String areaCode) {
	   if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
	   return areaCode;
	}
	
}