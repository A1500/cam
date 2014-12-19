package com.inspur.cams.comm.print.dao.jdbc;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;

/**
 * 跨省迁出 省内迁移 证明打印
 * @author Administrator
 *
 */
public class MigrationAppPrintDao extends IPrintDao {

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return BaseinfoPeople.class;
	}
	@Override
	public DataSet queryData(ParameterSet pset) {
		ToDate todate = new ToDate();
		String flag = (String)pset.getParameter("epflag");
		String serviceType = (String)pset.getParameter("serviceType");
		int type[]=new int[2];
		Object obj[] = new Object[2];
		StringBuffer sql = new StringBuffer("select t.photo_id ,t.NAME ,(case t.SEX when '1' then '男' when '2' then '女' end) as SEX,");
		sql.append("	t.ID_CARD, ");
		sql.append("	d.full_name as DOMICILE "); 
		if(serviceType != null && !"".equals(serviceType)) {
			if("14".equals(serviceType)){//退役军人伤残抚恤关系迁入
				//sql.append("	,'退役军人' as POBJECT_TYPE");
			}else if("23".equals(serviceType)||"25".equals(serviceType)){//三属抚恤定补关系迁移
				sql.append("	,(case b.DEPENDANT_TYPE_CODE when '21' then '烈士遗属' when '22' then '因公牺牲军人遗属' when '23' then '病故军人遗属' end) as POBJECT_TYPE");
			}else if("43".equals(serviceType)||"4A".equals(serviceType)||"47".equals(serviceType)||"4B".equals(serviceType)){//带病回乡,在乡复员军人定补关系迁移
				sql.append("	,(case b.DEMOBILIZED_TYEP_CODE when '41' then '在乡复员军人' when '42' then '带病回乡复员军人' end) as POBJECT_TYPE");
			}else if("53".equals(serviceType)||"55".equals(serviceType)||"63".equals(serviceType)||"65".equals(serviceType)){//参试,参战人员定补关系迁移
				sql.append("	,(case b.WAR_TYPE_CODE when '51' then '参战' when '61' then '参试' end) as POBJECT_TYPE");
			}else if("B4".equals(serviceType)||"B3".equals(serviceType)){//平反人员定补关系迁移
				sql.append("	,(case f.status_type when '1' then '部分60周岁以上烈士子女' when '2' then '部分60周岁以上错杀被平反人员子女' end) as POBJECT_TYPE");
			}else if("84".equals(serviceType)||"83".equals(serviceType)){//平反人员定补关系迁移
				sql.append("	,'年满60周岁农村籍退役士兵' as POBJECT_TYPE");
			}
		}
		if(serviceType != null && !"".equals(serviceType)) {
			if("23".equals(serviceType)||"43".equals(serviceType)||"14".equals(serviceType)||
					"63".equals(serviceType)||"53".equals(serviceType)||"47".equals(serviceType)||
					"B3".equals(serviceType)||"83".equals(serviceType)){//三属抚恤定补关系迁移
				sql.append("	,a.OUT_TOWN_ADUIT_INCHARGE ,	a.OUT_TOWN_ADUIT_ADVICE ");
				sql.append("	,a.OUT_CITY_ADUIT_INCHARGE ,	a.OUT_CITY_ADUIT_ADVICE ");
				sql.append("	,a.IN_TOWN_ADUIT_INCHARGE ,	a.IN_TOWN_ADUIT_ADVICE ");
				sql.append("	,a.IN_CITY_ADUIT_INCHARGE ,	a.IN_CITY_ADUIT_ADVICE ");
				sql.append("	,"+todate.todate("a.OUT_TOWN_ADUIT_APPROVE_DATE")+" OUT_TOWN_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("a.OUT_CITY_ADUIT_APPROVE_DATE")+" OUT_CITY_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("a.IN_TOWN_ADUIT_APPROVE_DATE")+" IN_TOWN_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("a.IN_CITY_ADUIT_APPROVE_DATE")+" IN_CITY_ADUIT_APPROVE_DATE ");
				/*sql.append("	, g.phone OUT_TOWN_CHECK_PHONE ");
				sql.append("	, h.phone OUT_CITY_CHECK_PHONE ");
				sql.append("	,  l.phone  IN_TOWN_CHECK_PHONE ");
				sql.append("	,  k.phone  IN_CITY_CHECK_PHONE ");*/
				sql.append("	,c.full_name as INGOING ,	a.ALLOWANCE_MONTH ");
			}else{
				sql.append("	,e.TOWN_ADUIT_INCHARGE ,	e.TOWN_ADUIT_ADVICE ");
				sql.append("	,e.CITY_ADUIT_INCHARGE ,	e.CITY_ADUIT_ADVICE ");
				sql.append("	,e.PROVINCE_CHECK_PEOPLE ,	e.PROVINCE_CHECK_ADVICE ");
				sql.append("	,e.PROVINCE_INCHARGE ,	e.PROVINCE_ADVICE ");
				sql.append("	,"+todate.todate("e.TOWN_ADUIT_APPROVE_DATE")+" TOWN_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("e.CITY_ADUIT_APPROVE_DATE")+" CITY_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("e.PROVINCE_CHECK_DATE")+" PROVINCE_CHECK_DATE ");
				sql.append("	,"+todate.todate("e.PROVINCE_APPROVE_DATE")+" AS PROVINCE_APPROVE_DATE ");
				/*sql.append("	, m.phone TOWN_CHECK_PHONE ");
				sql.append("	, h.phone CITY_CHECK_PHONE ");
				sql.append("	, l.phone  PROVINCE_CHECK_PHONE ");*/
				sql.append("	,e.INGOING_ADDRESS AS INGOING ,	e.ALLOWANCE_MONTH " );
			}
		}
		
		StringBuffer sql2 = new StringBuffer(
				" from	baseinfo_people t , DIC_CITY d ,bpt_people b "  
		);
		if(serviceType != null && !"".equals(serviceType)) {
			if("23".equals(serviceType)||"43".equals(serviceType)||"14".equals(serviceType)||
					"63".equals(serviceType)||"53".equals(serviceType)||"47".equals(serviceType)){//三属抚恤定补关系迁移
				sql2.append("	,DIC_CITY c ");
				/*sql2.append("	,DIC_BPT_CITY_PHONE g ");
				sql2.append("	,DIC_BPT_CITY_PHONE h ");
				sql2.append("	,DIC_BPT_CITY_PHONE l ");
				sql2.append("	,DIC_BPT_CITY_PHONE k ");*/
				sql2.append("	,bpt_province_migrate a " );
			}else if("B4".equals(serviceType)){
				sql2.append("	,bpt_apply_emigration e " );
				/*sql2.append("	,DIC_BPT_CITY_PHONE m ");
				sql2.append("	,DIC_BPT_CITY_PHONE h ");
				sql2.append("	,DIC_BPT_CITY_PHONE l ");*/
				sql2.append("	,BPT_PEOPLE_MARTYR_OFFSPRING f " );
			}else if("B3".equals(serviceType)){
				sql2.append("	,DIC_CITY c ");
				sql2.append("	,bpt_province_migrate a " );
				/*sql2.append("	,DIC_BPT_CITY_PHONE g ");
				sql2.append("	,DIC_BPT_CITY_PHONE h ");
				sql2.append("	,DIC_BPT_CITY_PHONE l ");
				sql2.append("	,DIC_BPT_CITY_PHONE k ");*/
				sql2.append("	,BPT_PEOPLE_MARTYR_OFFSPRING f " );
			}else if("84".equals(serviceType)){
				sql2.append("	,bpt_apply_emigration e " );
				/*sql2.append("	,DIC_BPT_CITY_PHONE m ");
				sql2.append("	,DIC_BPT_CITY_PHONE h ");
				sql2.append("	,DIC_BPT_CITY_PHONE l ");*/
				sql2.append("	,BPT_PEOPLE_RETIRED_SOLDIER f " );
			}else if("83".equals(serviceType)){
				sql2.append("	,DIC_CITY c ");
				/*sql2.append("	,DIC_BPT_CITY_PHONE g ");
				sql2.append("	,DIC_BPT_CITY_PHONE h ");
				sql2.append("	,DIC_BPT_CITY_PHONE l ");
				sql2.append("	,DIC_BPT_CITY_PHONE k ");*/
				sql2.append("	,bpt_province_migrate a " );
				sql2.append("	,BPT_PEOPLE_RETIRED_SOLDIER f " );
			}else{
				/*sql2.append("	,DIC_BPT_CITY_PHONE m ");
				sql2.append("	,DIC_BPT_CITY_PHONE h ");
				sql2.append("	,DIC_BPT_CITY_PHONE l ");*/
				sql2.append("	,bpt_apply_emigration e " );
			}
		}
		
		StringBuffer sql3 = new StringBuffer(" where 	t.personal_stats_tag != '4'	and t.DOMICILE_CODE = d.ID " );
		String applyId = (String)pset.getParameter("applyId");
		if(serviceType != null && !"".equals(serviceType)) {
			/*if("14".equals(serviceType)){//退役军人伤残抚恤关系迁入
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and c.ID = a.INGOING_CODE");
				sql3.append(" and a.service_type='14'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[1]=12;
					obj[1]=applyId;
				}
				sql3.append(" and a.COMMIT_FLAG = '0'");
			}else */
			if("23".equals(serviceType)){//三属抚恤定补关系省内迁移
				sql3.append(" and t.people_id=b.people_id " );
				sql3.append(" and t.people_id =a.people_id ");
				/*sql3.append("    and g.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(a.ingoing_code,0,6)||'000000') ");
				sql3.append("   and k.organ_code =(substr(a.ingoing_code,0,4)||'00000000') ");*/
				sql3.append(" and c.ID = a.INGOING_CODE");
				sql3.append(" and a.service_type='23'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and a.COMMIT_FLAG = '0'");
			}else if("25".equals(serviceType)){//三属抚恤定补关系跨省迁出
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =e.people_id");
				/*sql3.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(t.domicile_code,0,2)||'0000000000') ");*/
				sql3.append(" and e.service_type='25'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and e.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and e.COMMIT_FLAG = '0'");
			}else if("43".equals(serviceType)){//在乡复员军人定补关系省内迁移
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =a.people_id");
				/*sql3.append("    and g.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(a.ingoing_code,0,6)||'000000') ");
				sql3.append("   and k.organ_code =(substr(a.ingoing_code,0,4)||'00000000') ");*/
				sql3.append(" and c.ID = a.INGOING_CODE");
				sql3.append(" and a.service_type='43'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and a.COMMIT_FLAG = '0'");
			}else if("4A".equals(serviceType)){//在乡复员军人定补关系跨省迁出
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =e.people_id");
				/*sql3.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(t.domicile_code,0,2)||'0000000000') ");*/
				sql3.append(" and e.service_type='4A'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and e.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and e.COMMIT_FLAG = '0'");
			}else if("47".equals(serviceType)){//带病回乡退伍军人定补关系省内迁移
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =a.people_id");
				/*sql3.append("    and g.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(a.ingoing_code,0,6)||'000000') ");
				sql3.append("   and k.organ_code =(substr(a.ingoing_code,0,4)||'00000000') ");*/
				sql3.append(" and c.ID = a.INGOING_CODE");
				sql3.append(" and a.service_type='47'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and a.COMMIT_FLAG = '0'");
			}else if("4B".equals(serviceType)){//带病回乡退伍军人定补关系跨省迁出
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =e.people_id");
				/*sql3.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(t.domicile_code,0,2)||'0000000000') ");*/
				sql3.append(" and e.service_type='4B'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and e.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and e.COMMIT_FLAG = '0'");
			}else if("53".equals(serviceType)){//参战人员定补关系省内迁移
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =a.people_id");
				/*sql3.append("    and g.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(a.ingoing_code,0,6)||'000000') ");
				sql3.append("   and k.organ_code =(substr(a.ingoing_code,0,4)||'00000000') ");*/
				sql3.append(" and t.WAR_FLAG='1'");
				sql3.append(" and c.ID = a.INGOING_CODE");
				sql3.append(" and a.service_type='53'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and a.COMMIT_FLAG = '0'");
			}else if("55".equals(serviceType)){//参战人员定补关系跨省迁出
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =e.people_id");
				/*sql3.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(t.domicile_code,0,2)||'0000000000') ");*/
				sql3.append(" and t.WAR_FLAG='1'");
				sql3.append(" and e.service_type='55'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and e.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and e.COMMIT_FLAG = '0'");
			}else if("63".equals(serviceType)){//参试人员定补关系省内迁移
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and t.WAR_FLAG='1'");
				sql3.append(" and c.ID = a.INGOING_CODE");
				/*sql3.append("    and g.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(a.ingoing_code,0,6)||'000000') ");
				sql3.append("   and k.organ_code =(substr(a.ingoing_code,0,4)||'00000000') ");*/
				sql3.append(" and a.service_type='63'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and a.COMMIT_FLAG = '0'");
			}else if("65".equals(serviceType)){//参试人员定补关系跨省迁出
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =e.people_id");
				/*sql3.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(t.domicile_code,0,2)||'0000000000') ");*/
				sql3.append(" and t.WAR_FLAG='1'");
				sql3.append(" and e.service_type='65'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and e.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and e.COMMIT_FLAG = '0'");
			}else if("B4".equals(serviceType)){//平反人员定补关系跨省迁出
				sql3.append(" and t.people_id=f.people_id" );
				sql3.append(" and t.people_id=b.people_id" );
				/*sql3.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(t.domicile_code,0,2)||'0000000000') ");*/
				sql3.append(" and t.people_id =e.people_id");
				sql3.append(" and e.service_type='B4'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and e.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and e.COMMIT_FLAG = '0'");
			}else if("B3".equals(serviceType)){//平反人员定补关系省内迁移
				sql3.append(" and t.people_id=f.people_id" );
				sql3.append(" and t.people_id=b.people_id" );
				/*sql3.append("    and g.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(a.ingoing_code,0,6)||'000000') ");
				sql3.append("   and k.organ_code =(substr(a.ingoing_code,0,4)||'00000000') ");*/
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and c.ID = a.INGOING_CODE");
				sql3.append(" and a.service_type='B3'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and a.COMMIT_FLAG = '0'");
			}else if("83".equals(serviceType)){//60岁退役士兵人员定补关系省内迁移
				sql3.append(" and t.people_id=f.people_id" );
				sql3.append(" and t.people_id=b.people_id" );
				/*sql3.append("    and g.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(a.ingoing_code,0,6)||'000000') ");
				sql3.append("   and k.organ_code =(substr(a.ingoing_code,0,4)||'00000000') ");*/
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and c.ID = a.INGOING_CODE");
				sql3.append(" and a.service_type='83'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and a.COMMIT_FLAG = '0'");
			}else if("84".equals(serviceType)){//60岁退役士兵人员
				sql3.append(" and t.people_id=f.people_id" );
				sql3.append(" and t.people_id=b.people_id" );
				sql3.append(" and t.people_id =e.people_id");
				/*sql3.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql3.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql3.append(" 	and l.organ_code =(substr(t.domicile_code,0,2)||'0000000000') ");*/
				sql3.append(" and e.service_type='84'");
				if(applyId != null && !"".equals(applyId)) {
					sql3.append(" and e.apply_id=?");
					type[0]=12;
					obj[0]=applyId;
				}
				//sql3.append(" and e.COMMIT_FLAG = '0'");
			}
			
		}
		sql.append(sql2);
		sql.append(sql3);
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id=?" );
			type[1]=12;
			obj[1]=peopleId;
		}
		//System.out.println(sql.toString());
		return  this.executeDataset(sql.toString(),type,obj, true);
	}

	

}
