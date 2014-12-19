package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;

/**
 * 外省迁入 证明打印
 * 
 * @author Administrator
 * 
 */
public class intoMigrationPrintDao extends IPrintDao {

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return BaseinfoPeople.class;
	}

	@Override
	public DataSet queryData(ParameterSet pset) {
		ToDate todate = new ToDate();
		String flag = (String) pset.getParameter("epflag");
		String serviceType = (String) pset.getParameter("serviceType");
		int type[] = new int[2];
		Object obj[] = new Object[2];
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT A.OLD_PAPER_NO, A.INGOING_REASON, C.FULL_NAME || T.ADDRESS AS ADDRESS,\n");
		sql.append("       T.PHOTO_ID, T.TEL_MOBILE, T.BIRTHDAY, T.NAME,\n"); 
		sql.append("       (CASE T.SEX\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '男'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '女'\n"); 
		sql.append("        END) AS SEX, T.ID_CARD, F.CANT_NAME AS DOMICILE");
		sql.append("       ,"+todate.todate("a.TOWN_ADUIT__APPROVE_DATE")+"TOWN_ADUIT_APPROVE_DATE ");
		sql.append("       ,"+todate.todate("a.CITY_ADUIT_APPROVE_DATE")+"CITY_ADUIT_APPROVE_DATE ");
		sql.append("       ,"+todate.todate("a.PROVINCE_CHECK_DATE")+"PROVINCE_CHECK_DATE ");
		sql.append("        ,a.TOWN_ADUIT_INCHARGE, a.TOWN_ADUIT_ADVICE,a.CITY_ADUIT_INCHARGE,a.CITY_ADUIT_ADVICE,a.PROVINCE_CHECK_PEOPLE_ID,a.PROVINCE_CHECK_ADVICE ");
		sql.append("        ,A.PROVINCE_INCHARGE,"+todate.todate("a.PROVINCE_APPROVE_DATE")+" PROVINCE_APPROVE_DATE,A.PROVINCE_ADVICE ");
		if (serviceType != null && !"".equals(serviceType)) {
			if ("22".equals(serviceType)) {// 三属外省迁入
				sql.append("	,(case b.DEPENDANT_TYPE_CODE when '21' then '烈士遗属' when '22' then '因公牺牲军人遗属' when '23' then '病故军人遗属' end) as POBJECT_TYPE");
			} else if ("42".equals(serviceType) || "46".equals(serviceType)) {// 带病回乡,在乡复员军人定补关系外省迁入
				sql.append("	,(case b.DEMOBILIZED_TYEP_CODE when '41' then '在乡复员军人' when '42' then '带病回乡复员军人' end) as POBJECT_TYPE");
			} else if ("52".equals(serviceType) || "62".equals(serviceType)) {// 参试,参战人员定补关系迁入
				sql.append("	,(case b.WAR_TYPE_CODE when '51' then '参战' when '61' then '参试' end) as POBJECT_TYPE");
			} else if ("15".equals(serviceType) || "14".equals(serviceType)) {// 退役军人和外省伤残人员定补关系迁入
				sql.append( "	, (case g.disability_case_code when '1' then '因战' when '2' then '因公'  when '3' then '因病' end) as disability_case_code , ");
				sql.append(  "	(case g.disability_level_code when '01' then '一级' when '02' then '二级'  when '03' then '三级'  when '04' then '四级'  when '05' then '五级'  when '04' then '六级'  when '07' then '七级'  when '08' then '八级'  when '09' then '九级'  when '10' then '十级' end) as disability_level_code , ");
				sql.append(  "	g.conscript_date , ");
				sql.append( "	g.veterans_date , ");
				sql.append( "	(case b.DISABILITY_TYPE_CODE when '11' then '残疾军人'  when '12' then '伤残国家机关工作人员'  when '13' then '伤残人民警察'  when '14' then '伤残民兵民工'  when '15' then '因战因公伤残人员' end) as POBJECT_TYPE");
			}else if("B2".equals(serviceType)){//平反人员定补关系迁移
				sql.append("	,(case o.status_type when '1' then '部分60周岁以上烈士子女' when '2' then '部分60周岁以上错杀被平反人员子女' end) as POBJECT_TYPE");
			} else if("82".equals(serviceType)){//平反人员定补关系迁移
				sql.append("	,'年满60周岁农村籍退役士兵' as POBJECT_TYPE");
			}
		}
		sql.append("	,f.cant_name as INGOING ,	a.ALLOWANCE_MONTH ");

		StringBuffer sql2 = new StringBuffer(" from	baseinfo_people t , dic_city c,");
		sql2.append( "	bpt_people b, ");
		if(serviceType != null && !"".equals(serviceType)) {
			if("B2".equals(serviceType)){
				sql2.append("	BPT_PEOPLE_MARTYR_OFFSPRING o, " );
			} else if("15".equals(serviceType) || "14".equals(serviceType)){
				sql2.append( "	 bpt_people_disability g , ");
			}
		}
		sql2.append( "	bpt_apply_intoprovince a, ");
		
		sql2.append("	 pub_cant  f ");
		StringBuffer sql3 = new StringBuffer(" where 	t.personal_stats_tag != '4' and  t.apanage_code = c.id ");
		String applyId = (String) pset.getParameter("applyId");
		if (serviceType != null && !"".equals(serviceType)) {
			if ("22".equals(serviceType)) {// 三属抚恤定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='22'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("42".equals(serviceType)) {// 在乡复员军人定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='42'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("46".equals(serviceType)) {// 带病回乡退伍军人定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='46'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("52".equals(serviceType)) {// 参战人员定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='52'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("62".equals(serviceType)) {// 参试人员定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='62'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("65".equals(serviceType)) {// 参试人员定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='65'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("15".equals(serviceType)) {// 伤残人员定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and t.people_id =g.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='15'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("14".equals(serviceType)) {// 退役人员定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='14'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("B2".equals(serviceType)) {// 平反人员定补关系外省迁入
				sql3.append(" and t.people_id=o.people_id" );
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='B2'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			} else if ("82".equals(serviceType)) {// 平反人员定补关系外省迁入
				sql3.append(" and t.people_id=b.people_id");
				sql3.append(" and t.people_id =a.people_id");
				sql3.append(" and f.cant_code = a.INGOING_CODE");
				sql3.append(" and a.service_type='82'");
				if (applyId != null && !"".equals(applyId)) {
					sql3.append(" and a.apply_id=?");
					type[0] = 12;
					obj[0] = applyId;
				}
			}

		}
		sql.append(sql2);
		sql.append(sql3);
		String peopleId = (String) pset.getParameter("peopleId");
		if (peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id=?");
			type[1] = 12;
			obj[1] = peopleId;
		}
		return this.executeDataset(sql.toString(), type, obj, true);
	}

	public DataSet queryPhysical(ParameterSet pset) {
		String applyId = (String) pset.getParameter("applyId");
		String type = (String) pset.getParameter("type");
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT T.PHOTO_ID, T.NAME, T.DOMICILE_ADDRESS,\n");
		sql.append("       C.FULL_NAME || T.ADDRESS AS ADDRESS,\n"); 
		sql.append("       (CASE T.SEX\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '男'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '女'\n"); 
		sql.append("        END) AS SEX, T.ID_CARD, T.BIRTHDAY, T.TEL_MOBILE, T.WORK_UNIT_NAME,\n"); 
		sql.append("       T.POST_CODE, A.ISSUING_AUTHORITY, A.LAST_TIME, A.LAST_CONCLUSION,\n"); 
		sql.append("       (CASE A.DIS_LEVEL\n"); 
		sql.append("          WHEN '01' THEN\n"); 
		sql.append("           '一级'\n"); 
		sql.append("          WHEN '02' THEN\n"); 
		sql.append("           '二级'\n"); 
		sql.append("          WHEN '03' THEN\n"); 
		sql.append("           '三级'\n"); 
		sql.append("          WHEN '04' THEN\n"); 
		sql.append("           '四级'\n"); 
		sql.append("          WHEN '05' THEN\n"); 
		sql.append("           '五级'\n"); 
		sql.append("          WHEN '06' THEN\n"); 
		sql.append("           '六级'\n"); 
		sql.append("          WHEN '07' THEN\n"); 
		sql.append("           '七级'\n"); 
		sql.append("          WHEN '08' THEN\n"); 
		sql.append("           '八级'\n"); 
		sql.append("          WHEN '09' THEN\n"); 
		sql.append("           '九级'\n"); 
		sql.append("          WHEN '10' THEN\n"); 
		sql.append("           '十级'\n"); 
		sql.append("        END) AS DIS_LEVEL, A.APPLY_REASON, A.VILLAGE_VIEW, A.VILLAGE_TIME,\n"); 
		sql.append("       A.TWON_VIEW, A.TWON_TIME, A.COUNTY_VIEW, A.COUNTY_TIME, A.INSPECTION,\n"); 
		sql.append("       A.CONCLUSION, A.SIGNATURE, A.HOSPITAL_TIME, \n"); 
		if("11".equals(type)){//伤残
			sql.append("		d.VETERANS_DATE,d.CONSCRIPT_DATE,A.FORCES_NO,");
		}else if("65".equals(type)){//参试
			sql.append("		d.CONSCRIPTC_DATE,d.DECRUITMENT_DATE,d.FORCES_NO,");
		}else if("45".equals(type)){//带病
			sql.append("		d.CONSCRIPT_DATE,d.DECRUITMENT_DATE,d.FORCES_NO,");
		}
		sql.append("       A.DECRUITMENT_DATE,  A.DISABLED_ARMY_NO, A.ASDP_NO");
		
		sql.append(" from baseinfo_people t , bpt_physical_examination a ,dic_city c , ");
		if("11".equals(type)){//伤残
			sql.append("		BPT_PEOPLE_DISABILITY d");
		}else if("65".equals(type)){//参试
			sql.append("		BPT_PEOPLE_TESTED d");
		}else if("45".equals(type)){//带病
			sql.append("		BPT_PEOPLE_DEMOBILIZED_ILLNESS d");
		}
		sql.append(" where a.people_Id = t.people_Id and t.apanage_code = c.id and t.people_id=d.people_id ");
		
		sql.append(" and a.APPLY_ID = ?");

		DataSet ds = executeDataset(sql.toString(),
				new int[] { Types.VARCHAR }, new Object[] { applyId }, true);
		return ds;
	}
	public DataSet queryDemobilizedillCheck(ParameterSet pset){
  		String applyId =(String)pset.get("applyId");
		int[] type = new int[]{12};
		Object[] obj= new Object[]{applyId};
  		StringBuffer sql = new StringBuffer();
  		sql.append("select C.APPLY_ID,C.PEOPLE_ID,C.HOSPITAL,C.TO_CHECK_DATE,C.TO_CHECK_ILLNESS,d.name as TO_ORGAN,");
  		sql.append("C.CHECK_RESULT,C.SYSTEM,C.ILLNESS,C.SIGN,C.SIGN_DATE,C.TO_ORGAN_ID,");
  		sql.append(" case C.ADVICE when '0' then '不符合' when '1' then '符合' end as ADVICE,");
  		sql.append(" case b.sex when '1' then '男' when '2' then '女' end as SEX,");
  		sql.append(" case C.ADVICE when '1' then C.SYSTEM||'系统'||C.ILLNESS end as SYSILL,");
  		sql.append("C.TO_ORGAN_DATE, b.name,b.address,b.id_card,b.people_id,b.birthday,b.PHOTO_ID ");
  		sql.append("  from baseinfo_people b,BPT_DEMOBILIZEDILLNESS_CHECK c, dic_city d where b.people_id= c.people_id ");
  		sql.append(" and d.id=c.TO_ORGAN_ID and C.apply_Id=? ");
  		return this.executeDataset(sql.toString(), type,obj, true);
		
		
  	}
}
