package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;

/**
 * @title:AssDisabilityAppPrintDao
 * @description:伤残模块相关打印
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
 public class AssDisabilityAppPrintDao extends IPrintDao{
	 ToDate todate = new ToDate();
	@Override
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}

	/**
	 * 评残等级审批申请表打印
	 */
	public DataSet queryData(ParameterSet pst) {
		StringBuffer bf = new StringBuffer();
		bf.append(" select t.photo_id,t.name as name ,(case t.sex when '1' then '男' when '2' then '女'end) as sex,c.full_name || t.address as address,");
		bf.append(" t.id_card as idcard,t.birthday as birthday,d.name as nation,");
		bf.append(" b.conscript_date as conscriptDate,b.veterans_date as veteransDate,b.RETIRED_DATE as retiredDate,");
		bf.append(" b.uinit_of_disability as uinitOfDisability,g.name as disabilityGenusCode,");
		bf.append(" (case bp.disability_type_code when '11' then '残疾军人' when '12' then '伤残国家机关工作人员' when '13' then '伤残人民警察' when '14' then '伤残民兵民工' when '15' then '因战因公伤残人员' end ) as disabilityType,");
		bf.append(" dc.name as dcase,dl.name as dlevel,");
		bf.append(" b.disability_date as disdate,b.disability_add as disadd,b.disability_body as disbody, b.disability_reason as disreason,");

		bf.append(" bd.TOWN_ADUIT_BULLETIN_RESULT,\n");
		bf.append(" (case bd.TOWN_ADUIT_DISABILITY_NATURE when '1' then '因战' when '2' then '因公' when '3' then '因病' end) as TOWN_ADUIT_DISABILITY_NATURE,\n"); 
		bf.append("      (case bd.TOWN_ADUIT_DISABILITY_LEVEL when '01' then '一级' when '02' then '二级' when '03' then '三级' when '04' then '四级' when '05' then '五级' when '06' then '六级' when '07' then '七级' when '08' then '八级' when '09' then '九级' when '10' then '十级' end) as TOWN_ADUIT_DISABILITY_LEVEL,\n"); 
		bf.append("      bd.TOWN_ADUIT_INCHARGE,"+todate.todate("bd.town_aduit__approve_date")+" town_aduit_approve_date ,\n"); 
		bf.append("      (case bd.CITY_ADUIT_DISABILITY_LEVEL when '01' then '一级' when '02' then '二级' when '03' then '三级' when '04' then '四级' when '05' then '五级' when '06' then '六级' when '07' then '七级' when '08' then '八级' when '09' then '九级' when '10' then '十级' end ) as CITY_ADUIT_DISABILITY_LEVEL,\n"); 
		bf.append("      bd.CITY_ADUIT_INCHARGE,"+todate.todate("bd.city_aduit_approve_date")+" city_aduit_approve_date,\n"); 
		bf.append("      (case bd.CITY_ADUIT_DISABILITY_NATURE when '1' then '因战' when '2' then '因公' when '3' then '因病' end) as CITY_ADUIT_DISABILITY_NATURE,\n"); 
		bf.append("      (case bd.PROVINCE_LEVEL when '01' then '一级' when '02' then '二级' when '03' then '三级' when '04' then '四级' when '05' then '五级' when '06' then '六级' when '07' then '七级' when '08' then '八级' when '09' then '九级' when '10' then '十级' end) as PROVINCE_ADUIT_DISABILITY_LEVE,\n"); 
		bf.append("      bd.PROVINCE_INCHARGE,"+todate.todate("bd.PROVINCE_ADUIT_APPROVE_DATE")+" PROVINCE_ADUIT_APPROVE_DATE,\n"); 
		bf.append("      (case bd.PROVINCE_VERIFY_DISABILITY_NAT when '1' then '因战' when '2' then '因公' when '3' then '因病' end) as PROVINCE_ADUIT_DISABILITY_NATU,\n"); 
		bf.append("    (case bd.OLD_DISABILITY_NATURE when '1' then '因战' when '2' then '因公' when '3' then '因病' end) as OLD_DISABILITY_NATURE,\n"); 
		bf.append("    (case bd.OLD_DISABILITY_LEVEL when '01' then '一级' when '02' then '二级' when '03' then '三级' when '04' then '四级' when '05' then '五级' when '06' then '六级' when '07' then '七级' when '08' then '八级' when '09' then '九级' when '10' then '十级' end) as OLD_DISABILITY_LEVEL,");

		bf.append(" bd.DISABILITY_DATE as adjdate,bd.DISABILITY_ADD as adjadd,bd.DISABILITY_BODY as adjbody, bd.DISABILITY_REASON as adjreason,bd.ADJUST_REASON as adjApplyReason");
		bf.append(" from baseinfo_people t, dic_city c, dic_nation d,bpt_people_disability b,dic_disability_genus g, ");
		bf.append(" bpt_people bp,dic_disability_case dc,dic_disability_level dl,BPT_APPLY_DISABILITY bd ");
		bf.append(" where t.apanage_code = c.id and  t.nation=d.code and t.people_id  = b.people_id and b.disability_genus_code=g.code");
		bf.append(" and t.people_id=bp.people_id and t.disability_case_code=dc.code(+) and t.disability_level_code=dl.code(+) ");
		bf.append(" and t.disability_flag='1' and t.personal_stats_tag != '4' and t.people_id= bd.people_id ");
		
		String peopleId = (String)pst.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			bf.append(" and t.people_id= ? ");
		}
		String applyId = (String)pst.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			bf.append(" and bd.apply_id= ? ");
		}
		return  this.executeDataset(bf.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{peopleId,applyId}, true);
	}
	
	/**
	 * 打印伤残鉴定介绍信
	 * @param pset
	 * @return
	 */
	public DataSet queryDisIdenti(ParameterSet pset) {
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select c.full_name as dicname,b.TEL_MOBILE , b.photo_id, i.people_id,i.numbering,i.identification_unit,");
		sql.append(" i.introduction_unit,i.introduction_date,i.identification_date,i.agent,i.agent_phone,");
		sql.append(" i.name,(case i.sex when '1' then '男' when '2' then '女' end) as sex,i.birthday,i.domicile_code,i.id_card,i.injury_status,");
		sql.append(" i.address,i.work_unit_name,i.disability_date||'	'||i.disability_reason as dateReason,i.disability_body,i.disability_reason||' '||i.disability_body as disabilityInfo , i.data_situation,i.note");
		sql.append(" from bpt_disability_identi i , dic_city c,BPT_APPLY_DISABILITY bd,BASEINFO_PEOPLE b ");
		sql.append(" where i.people_id = bd.people_id and i.people_id = b.people_id and i.domicile_code=c.id ");
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and i.people_id= ? ");
		}
		String applyId = (String)pset.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and bd.apply_id= ? ");
		}
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{peopleId,applyId},true);
	}
	
	
	/**
	 * 伤残换证补证以及变更打印
	 * @param pset
	 * @return
	 */
	public DataSet queryExchaCertiDis(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select c.full_name  dicname,t.PHOTO_ID, t.name as name ,(case t.sex when '1' then '男' when '2' then '女'end) as sex,");
		sql.append(" t.id_card as idcard,t.birthday as birthday,d.name as nation,a.exchange_reason as exchange_reason,t.disability_no as disability_no,");
		sql.append(" b.conscript_date as conscriptDate,b.veterans_date as veteransDate,");
		sql.append(  todate.todate("a.town_aduit__approve_date")+" town_aduit_approve_date,");
		sql.append(  todate.todate("a.city_aduit_approve_date")+" city_aduit_approve_date,");
		sql.append(  todate.todate("a.PROVINCE_CHECK_DATE")+" province_check_date,");
		sql.append(" a.town_aduit_advice,a.TOWN_ADUIT_INCHARGE,a.CITY_ADUIT_INCHARGE,a.CITY_ADUIT_ADVICE, ");
		sql.append(" a.PROVINCE_CHECK_PEOPLE_ID,a.PROVINCE_CHECK_ADVICE, ");
		sql.append(" dc.name as disability_case,dl.name as disability_level,a.new_disability_no ,a.change_reason_content");
		sql.append(" from baseinfo_people t ,dic_nation d,bpt_people_disability b,dic_disability_case dc,dic_disability_level dl,dic_city c,bpt_apply_disability a,bpt_people bp");
		sql.append(" where t.domicile_code=c.id ");
		sql.append(" and t.nation=d.code and t.people_id  = b.people_id and t.people_id=bp.people_id  and t.disability_case_code=dc.code");
		sql.append(" and t.disability_level_code=dl.code and a.people_id = t.people_id ");
		sql.append(" and t.disability_flag='1' and t.personal_stats_tag != '4'");
		String serviceType = (String)pset.getParameter("serviceType");
		if(serviceType != null && !"".equals(serviceType)) {
			sql.append(" and a.service_type= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		String applyId = (String)pset.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and a.apply_id= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return this.executeDataset(sql.toString(),types,args, true);
	}
	
	/**
	 * 伤残退役军人迁入
	 * @param pset
	 * @return
	 */
	public DataSet queryVeterIntoProvince(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.PHOTO_ID,T.TEL_MOBILE, C.FULL_NAME AS DICNAME, T.NAME AS NAME,\n");
		sql.append("       (CASE T.SEX\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '男'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '女'\n"); 
		sql.append("        END) AS SEX, T.ID_CARD AS IDCARD, T.BIRTHDAY AS BIRTHDAY,\n"); 
		sql.append("       A.OLD_DISABILITY_NO AS OLD_PAPER_NO, A.ALLOWANCE_MONTH,\n"); 
		sql.append("       A.INGOING_ADDRESS, A.EXCHANGE_REASON AS INGOING_REASON,\n"); 
		sql.append("       A.TOWN_ADUIT_INCHARGE, B.CONSCRIPT_DATE AS CONSCRIPTDATE,\n"); 
		sql.append("       A.CITY_ADUIT_INCHARGE,A.PROVINCE_CHECK_PEOPLE_ID, ");
		sql.append("       B.VETERANS_DATE AS VETERANSDATE, DC.NAME AS DISABILITY_CASE,\n"); 
		sql.append("       DL.NAME AS DISABILITY_LEVEL,\n"); 
		sql.append("       DC_TOWN.NAME AS TOWN_ADUIT_DISABILITY_NATURE,\n"); 
		sql.append("       DL_TOWN.NAME AS TOWN_ADUIT_DISABILITY_LEVEL,\n"); 
		sql.append("       DC_CITY.NAME AS CITY_ADUIT_DISABILITY_NATURE,\n"); 
		sql.append("       DL_CITY.NAME AS CITY_ADUIT_DISABILITY_LEVEL,\n"); 
		sql.append(  todate.todate("a.TOWN_ADUIT__APPROVE_DATE")+" TOWN_ADUIT_APPROVE_DATE,");
		sql.append(  todate.todate("a.CITY_ADUIT_APPROVE_DATE")+" CITY_ADUIT_APPROVE_DATE,");
		sql.append(  todate.todate("a.PROVINCE_CHECK_DATE")+" PROVINCE_CHECK_DATE,");
		sql.append("       a.TOWN_ADUIT_ADVICE,a.CITY_ADUIT_ADVICE,a.PROVINCE_CHECK_ADVICE, ");
		sql.append("       DC_PROVINCE.NAME AS PROVINCE_VERIFY_DISABILITY_NAT,\n"); 
		sql.append("       DL_PROVINCE.NAME AS PROVINCE_LEVEL\n"); 
		sql.append("  FROM BASEINFO_PEOPLE T, BPT_PEOPLE_DISABILITY B, DIC_DISABILITY_CASE DC,\n"); 
		sql.append("       DIC_DISABILITY_LEVEL DL, DIC_CITY C, BPT_PEOPLE BP,\n"); 
		sql.append("       BPT_APPLY_DISABILITY A, DIC_DISABILITY_CASE DC_TOWN,\n"); 
		sql.append("       DIC_DISABILITY_LEVEL DL_TOWN, DIC_DISABILITY_CASE DC_CITY,\n"); 
		sql.append("       DIC_DISABILITY_LEVEL DL_CITY, DIC_DISABILITY_CASE DC_PROVINCE,\n"); 
		sql.append("       DIC_DISABILITY_LEVEL DL_PROVINCE\n"); 
		sql.append(" WHERE T.DOMICILE_CODE = C.ID AND T.PEOPLE_ID = B.PEOPLE_ID AND\n"); 
		sql.append("       T.PEOPLE_ID = BP.PEOPLE_ID AND B.VERTERANS_CASE_CODE = DC.CODE(+) AND\n"); 
		sql.append("       B.VERTERANS_LEVEL_CODE = DL.CODE(+) AND A.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sql.append("       T.DISABILITY_FLAG = '1' AND T.PERSONAL_STATS_TAG != '4' AND\n"); 
		sql.append("       A.TOWN_ADUIT_DISABILITY_NATURE = DC_TOWN.CODE(+) AND\n"); 
		sql.append("       A.TOWN_ADUIT_DISABILITY_LEVEL = DL_TOWN.CODE(+) AND\n"); 
		sql.append("       A.CITY_ADUIT_DISABILITY_NATURE = DC_CITY.CODE(+) AND\n"); 
		sql.append("       A.CITY_ADUIT_DISABILITY_LEVEL = DL_CITY.CODE(+) AND\n"); 
		sql.append("       A.PROVINCE_VERIFY_DISABILITY_NAT = DC_PROVINCE.CODE(+) AND\n"); 
		sql.append("       A.PROVINCE_LEVEL = DL_PROVINCE.CODE(+)");
		String serviceType = (String)pset.getParameter("serviceType");
		if(serviceType != null && !"".equals(serviceType)) {
			sql.append(" and a.service_type= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		String applyId = (String)pset.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and a.apply_id= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return this.executeDataset(sql.toString(),types,args, true);
	}
	
	/**
	 * 外省伤残抚恤关系迁入我省打印
	 * @param pset
	 * @return
	 */
	public DataSet queryDisIntoProvince(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select c.full_name as dicname, t.name as name ,(case t.sex when '1' then '男' when '2' then '女'end) as sex,");
		sql.append(" t.id_card as idcard,t.birthday as birthday,a.old_paper_no,a.allowance_month,a.ingoing_address,a.ingoing_reason,");
		sql.append(" b.conscript_date as conscriptDate,b.veterans_date as veteransDate, dc.name as disability_case,dl.name as disability_level");
		sql.append(" from baseinfo_people t , bpt_people_disability b,dic_disability_case dc,dic_disability_level dl,");
		sql.append(" dic_city c ,BPT_PEOPLE bp,bpt_apply_intoprovince a");
		sql.append(" where t.domicile_code=c.id ");
		sql.append(" and t.people_id  = b.people_id and t.people_id=bp.people_id and t.disability_case_code=dc.code");
		sql.append(" and t.disability_level_code=dl.code and a.people_id = t.people_id");
		sql.append(" and t.disability_flag='1' and t.personal_stats_tag != '4'");
		String serviceType = (String)pset.getParameter("serviceType");
		if(serviceType != null && !"".equals(serviceType)) {
			sql.append(" and a.service_type= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		String applyId = (String)pset.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and a.apply_id= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return this.executeDataset(sql.toString(),types,args, true);
	}
	
	/**
	 * 受理通知书打印
	 * @param pset
	 * @return
	 */
	public DataSet queryAcceptNotice(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT N.NAME, N.NOTICE_LETTER, N.NOTICE_NO,\n");
		sql.append("       (CASE N.SERVICE_TYPE\n"); 
		sql.append("          WHEN '0' THEN\n"); 
		sql.append("           '评定残疾等级'\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '调整残疾等级'\n"); 
		sql.append("        END) AS SERVICE_TYPE, N.NOTICE_DATE, C.NAME || '民政局' AS DOMICILE\n"); 
		sql.append("  FROM BPT_APPLY_DISABILITY_NOTICE N, BPT_APPLY_DISABILITY BD, DIC_CITY C,\n"); 
		sql.append("       BASEINFO_PEOPLE P\n"); 
		sql.append(" WHERE N.PEOPLE_ID = BD.PEOPLE_ID AND BD.PEOPLE_ID = P.PEOPLE_ID AND\n"); 
		sql.append("       C.ID = SUBSTR(P.DOMICILE_CODE, 1, 6) || '000000' AND P.PEOPLE_ID = ?");

		String applyId = (String)pset.getParameter("applyId");
		String peopleId = (String)pset.getParameter("peopleId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and bd.apply_id= ? ");
		}
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{peopleId,applyId},true);
	}
	
	/**
	 * 残疾军人换证呈报表
	 * @param pset
	 * @return
	 */
	public DataSet queryReplacement(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT T.NAME, T.PHOTO_ID, \n");
		sql.append("       (CASE T.SEX \n"); 
		sql.append("         WHEN '1' THEN \n"); 
		sql.append("          '男' \n"); 
		sql.append("         WHEN '2' THEN \n"); 
		sql.append("          '女' \n"); 
		sql.append("       END) AS SEX, \n"); 
		sql.append("       T.BIRTHDAY, \n"); 
		sql.append("       t.id_card, \n"); 
		sql.append("       t.disability_no, \n"); 
		sql.append("       (CASE B.DISABILITY_CASE_CODE \n"); 
		sql.append("         WHEN '1' THEN \n"); 
		sql.append("          '因战' \n"); 
		sql.append("         WHEN '2' THEN \n"); 
		sql.append("          '因公' \n"); 
		sql.append("         WHEN '3' THEN \n"); 
		sql.append("          '因病' \n"); 
		sql.append("       END) AS DISABILITY_CASE_CODE, \n"); 
		sql.append("       (CASE B.DISABILITY_LEVEL_CODE \n"); 
		sql.append("         WHEN '01' THEN \n"); 
		sql.append("          '一级' \n"); 
		sql.append("         WHEN '02' THEN \n"); 
		sql.append("          '二级' \n"); 
		sql.append("         WHEN '03' THEN \n"); 
		sql.append("          '三级' \n"); 
		sql.append("         WHEN '04' THEN \n"); 
		sql.append("          '四级' \n"); 
		sql.append("         WHEN '05' THEN \n"); 
		sql.append("          '五级' \n"); 
		sql.append("         WHEN '06' THEN \n"); 
		sql.append("          '六级' \n"); 
		sql.append("         WHEN '07' THEN \n"); 
		sql.append("          '七级' \n"); 
		sql.append("         WHEN '08' THEN \n"); 
		sql.append("          '八级' \n"); 
		sql.append("         WHEN '09' THEN \n"); 
		sql.append("          '九级' \n"); 
		sql.append("         WHEN '10' THEN \n"); 
		sql.append("          '十级' \n"); 
		sql.append("       END) AS DISABILITY_LEVEL_CODE, \n"); 
		sql.append("       C.FULL_NAME AS ADDRESS, \n"); 
		sql.append("       b.DISABILITY_BODY \n"); 
		sql.append("  FROM BASEINFO_PEOPLE T, DIC_CITY C, bpt_people_disability B \n"); 
		sql.append("  where t.domicile_code=c.id and t.people_id=b.people_id");
		sql.append("    AND t.PEOPLE_ID = ?");

		String peopleId = (String)pset.getParameter("peopleId");
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);
	}
	/**
	 * 公示书打印
	 * @param pset
	 * @return
	 */
	public DataSet queryOpenNotice(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		//String organId = (String)pset.getParameter("organId");
		sql.append("SELECT T.NAME,\n");
		sql.append("       (CASE T.SEX\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '男'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '女'\n"); 
		sql.append("        END) AS SEX, T.BIRTHDAY, C.FULL_NAME || T.ADDRESS AS ADDRESS,\n"); 
		sql.append("       T.WORK_UNIT_NAME, B.DISABILITY_DATE, B.DISABILITY_ADD,\n"); 
		sql.append("       B.DISABILITY_REASON, B.DISABILITY_CONDITION, B.OPEN_DATE,\n"); 
		sql.append("       B.OPENEND_DATE, B.OPENSTART_DATE, P1.PHONE AS XIANPHONE,\n"); 
		sql.append("       P1.ORGAN_NAME AS ORGAN_NAME, P1.ADDRESS AS XIANADDRESS,\n"); 
		sql.append("       (CASE B.DISABILITY_CASE_CODE\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '因战'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '因公'\n"); 
		sql.append("          WHEN '3' THEN\n"); 
		sql.append("           '因病'\n"); 
		sql.append("        END) AS DISABILITY_CASE_CODE,\n"); 
		sql.append("       (CASE B.DISABILITY_LEVEL_CODE\n"); 
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
		sql.append("        END) AS DISABILITY_LEVEL_CODE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE T, DIC_CITY C, BPT_DISABILITY_OPEN B,\n"); 
		sql.append("       BPT_APPLY_DISABILITY BD, DIC_BPT_CITY_PHONE P1");
		sql.append(" where " );
		sql.append("	t.apanage_code=c.id and t.PEOPLE_ID= b.PEOPLE_ID and b.apply_id=bd.apply_id " );
		sql.append("	and ");
		sql.append(" substr(t.domicile_code,0,6)||'000000' ");
		sql.append(" = p1.ORGAN_CODE" );
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		String applyId = (String)pset.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and bd.apply_id= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return this.executeDataset(sql.toString(),types,args, true);
	}
	
	/**
	 * 伤残跨省迁出 省内迁移 证明打印
	 * @param pset
	 * @return
	 */
	public DataSet queryProvinceMigration(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String serviceType = (String)pset.getParameter("serviceType");
		int type[]=new int[2];
		Object obj[] = new Object[2];
		sql.append("select\n");
		sql.append("t.NAME,\n"); 
		sql.append("(case t.SEX when '1' then '男' when '2' then '女' end) as SEX,\n"); 
		sql.append("t.ID_CARD,\n"); 
		sql.append("t.DISABILITY_NO,\n"); 
		sql.append("dc.name as disability_case,\n"); 
		sql.append("dl.name as disability_level,\n"); 
		sql.append("g.name as DISABILITY_GENUS_CODE,");
		if(serviceType != null && !"".equals(serviceType)) {
			if("16".equals(serviceType)){
				sql.append("	a.OUT_TOWN_ADUIT_INCHARGE ,	a.OUT_TOWN_ADUIT_ADVICE ");
				sql.append("	,a.OUT_CITY_ADUIT_INCHARGE ,	a.OUT_CITY_ADUIT_ADVICE ");
				sql.append("	,a.IN_TOWN_ADUIT_INCHARGE ,	a.IN_TOWN_ADUIT_ADVICE ");
				sql.append("	,a.IN_CITY_ADUIT_INCHARGE ,	a.IN_CITY_ADUIT_ADVICE ");
				sql.append("	,"+todate.todate("a.OUT_TOWN_ADUIT_APPROVE_DATE")+" OUT_TOWN_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("a.OUT_CITY_ADUIT_APPROVE_DATE")+" OUT_CITY_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("a.IN_TOWN_ADUIT_APPROVE_DATE")+" IN_TOWN_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("a.IN_CITY_ADUIT_APPROVE_DATE")+" IN_CITY_ADUIT_APPROVE_DATE ");
				/*sql.append("	, m.phone OUT_TOWN_CHECK_PHONE ");
				sql.append("	, h.phone OUT_CITY_CHECK_PHONE ");
				sql.append("	,  l.phone  IN_TOWN_CHECK_PHONE ");
				sql.append("	,  k.phone  IN_CITY_CHECK_PHONE, ");*/
				sql.append("	,a.ALLOWANCE_MONTH as PALLOWANCE_MONTH,c.name as PINGOING_CODE ");
			}else if("19".equals(serviceType)){
				sql.append("	e.TOWN_ADUIT_INCHARGE ,	e.TOWN_ADUIT_ADVICE ");
				sql.append("	,e.CITY_ADUIT_INCHARGE ,	e.CITY_ADUIT_ADVICE ");
				sql.append("	,e.PROVINCE_CHECK_PEOPLE ,	e.PROVINCE_CHECK_ADVICE ");
				sql.append("	,"+todate.todate("e.TOWN_ADUIT_APPROVE_DATE")+" TOWN_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("e.CITY_ADUIT_APPROVE_DATE")+" CITY_ADUIT_APPROVE_DATE ");
				sql.append("	,"+todate.todate("e.PROVINCE_CHECK_DATE")+" PROVINCE_CHECK_DATE ");
				/*sql.append("	, m.phone TOWN_CHECK_PHONE ");
				sql.append("	, h.phone CITY_CHECK_PHONE ");
				sql.append("	, l.phone  PROVINCE_CHECK_PHONE, ");*/
				sql.append("	,e.ALLOWANCE_MONTH as EALLOWANCE_MONTH,e.INGOING_ADDRESS  ");
			}
		}
		sql.append(" from	baseinfo_people t , bpt_people_disability b, " );
		/*sql.append("	DIC_BPT_CITY_PHONE m ");
		sql.append("	,DIC_BPT_CITY_PHONE h ");
		sql.append("	,DIC_BPT_CITY_PHONE l ,");*/
		sql.append(" dic_disability_case dc,DIC_DISABILITY_GENUS g ,dic_disability_level dl ,");
		if(serviceType != null && !"".equals(serviceType)) {
			if("16".equals(serviceType)){
				sql.append("	DIC_BPT_CITY_PHONE k, ");
				sql.append("	bpt_province_migrate a, DIC_CITY c " );
			}else if("19".equals(serviceType)){
				sql.append("	bpt_apply_emigration e " );
			}
		}
		sql.append(" where\n");
		sql.append(" t.PEOPLE_ID= b.PEOPLE_ID\n"); 
		sql.append(" AND b.disability_genus_code=g.code\n"); 
		sql.append(" and b.disability_level_code=dl.code\n"); 
		sql.append(" and t.disability_case_code=dc.code\n"); 
		sql.append(" and t.disability_flag='1'\n"); 
		sql.append(" and t.personal_stats_tag != '4'");
		
		String applyId = (String)pset.getParameter("applyId");
		if(serviceType != null && !"".equals(serviceType)) {
			if("16".equals(serviceType)){
				sql.append(" and t.people_id =a.people_id");
				/*sql.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql.append(" 	and l.organ_code =(substr(a.ingoing_code,0,6)||'000000') ");
				sql.append("   and k.organ_code =(substr(a.ingoing_code,0,4)||'00000000') ");*/
				sql.append("	and c.ID = a.INGOING_CODE ");
				sql.append(" and a.service_type='16'");
				if(applyId != null && !"".equals(applyId)) {
					sql.append(" and a.apply_id = ?");
					type[0]=12;
					obj[0]=applyId;
				}
			}else if("19".equals(serviceType)){
				/*sql.append("    and m.organ_code =(substr(t.domicile_code,0,6)||'000000') ");
				sql.append("    and h.organ_code = (substr(t.domicile_code,0,4)||'00000000') ");
				sql.append(" 	and l.organ_code =(substr(t.domicile_code,0,2)||'0000000000') ");*/
				sql.append(" and t.people_id =e.people_id");
				sql.append(" and e.service_type='19'");
				if(applyId != null && !"".equals(applyId)) {
					sql.append(" and e.apply_id = ?");
					type[0]=12;
					obj[0]=applyId;
				}
			}
		}
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id=?");
			type[1]=12;
			obj[1]=peopleId;
		}
		DataSet ds = this.executeDataset(sql.toString(), type, obj, true);
		return ds;
	}
	/**
	 * 不予评残调残决定书打印
	 * @param pset
	 * @return
	 */
	public DataSet queryDecisionLetter(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> argsList = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		String applyId = (String)pset.getParameter("applyId");
		String peopleId = (String)pset.getParameter("peopleId");
		String organId = (String)pset.getParameter("organId");
		sql.append("SELECT T.NAME,\n");
		sql.append("       (CASE L.SERVICE_TYPE\n"); 
		sql.append("          WHEN '0' THEN\n"); 
		sql.append("           '评定伤残等级'\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '调整伤残等级'\n"); 
		sql.append("        END) AS TYPE, L.NO_FIT AS NOFIT, L.FOUNDATION AS FOUNDATION,\n"); 
		sql.append("       L.DECISION_DATE AS DECISIONDATE, C.NAME || '民政局' AS DOMICILE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE T, BPT_DECISION_LETTER L, DIC_CITY C\n"); 
		sql.append(" WHERE L.PEOPLE_ID = T.PEOPLE_ID AND '"); 
		sql.append(organId.substring(0, 6));
		sql.append("000000");
		sql.append("' = C.ID " );

		/*sql.append(
			"select " +
			"	t.NAME," +
			"	(case l.SERVICE_TYPE when '0' then '评定伤残等级' when '1' then '调整伤残等级' end) as type," +
			"	(case l.NO_FIT when '01' then '不属于因战因公致残' when '02' then '不属民政部门评残人员范围' when '03' then '残情达不到《军人残疾等级评定标准》' when '04' then '其它具体意见'" +
			"		when '11' then '无退伍手续或证件' when '12' then '其他具体意见' " +
			"		when '21' then '不属于带病回乡退伍军人认定范围（仅限义务兵和初级士官）' when '22' then '无退役证、军队医院证明等材料' when '23' then '服役期间所患疾病不属于规定慢性病' when '24' then '生活状况不符合规定条件' when '25' then '其他具体意见'" +
			"		when '31' then '档案材料无参战记载' when '32' then '无参战立功、授奖证件等相关证明材料' when '33' then '不符合“无工作单位”规定' when '34' then '生活状况不符合规定条件' when '35' then '其他具体意见'" +
			"		when '41' then '档案材料无参试、涉核记载' when '42' then '无参试、涉核相关证明材料（指个人自述，经省厅与绝密件比对出具的证明）' when '43' then '不符合“无工作单位”规定' when '44' then '生活状况不符合规定条件' when '45' then '其它具体意见'" +
			"	 	 end) as nofit," +
			"	(case l.FOUNDATION when '01' then '《军人抚恤优待条例》第'||l.CLAUSE ||'条规定' when '02' then '《伤残抚恤管理办法》第'||l.CLAUSE ||'条规定' when '03' then '《山东省实施<伤残抚恤管理办法>细则（试行）第'||l.CLAUSE ||'条规定' when '04' then '《关于国家机关工作人员、人民警察伤亡抚恤有关问题的通知》' when '05' then '其他相关依据'" +
			"		when '11' then '《军人抚恤优待条例》规定' " +
			"		when '21' then '《军人抚恤优待条例》规定' when '22' then '《民政部关于带病回乡退伍军人认定及待遇的通知》（民发［2009］168号）规定' when '23' then '《山东省民政厅关于做好带病回乡退伍军人身份认定工作的通知》（鲁民［2008］83号）规定'" +
			"		when '31' then '《军人抚恤优待条例》规定' when '32' then '《关于落实优抚对象和部分军队退役人员有关政策的意见》（济民函［2007］41号）规定' " +
			"		when '41' then '《军人抚恤优待条例》规定' when '42' then '《关于落实优抚对象和部分军队退役人员有关政策的意见》（济民函［2007］41号）规定' " +
			"		 end) as foundation," +
			"	l.DECISION_DATE as decisionDate," +
			"	'" +domicile+"' as domicile"+
			//"	p2.NAME||P1.NAME||'民政局' AS  domicile " +
			" from" +
			"	baseinfo_people t , bpt_decision_letter l " +
			//",dic_city p1, dic_city p2 " +
			" where " +
			"	l.people_id=t.people_id "
			//"	and substr(l.organ_id,0,6)||'000000' = p1.ID" +
			//"	and substr(l.organ_id,0,4)||'00000000' = p2.ID" 
		);*/
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and l.people_id=?");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and l.apply_id=?");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		int typesLength = typeList.size();
		int argsLength = argsList.size();
		DataSet ds = new DataSet();
		if(typesLength!=0&&argsLength!=0){
			int[] typeArray = new int[typesLength];
			for(int i=0;i<typesLength;i++){
				typeArray[i] = (Integer)typeList.get(i);
			}
			Object[] argArray = argsList.toArray(new Object[argsLength]);
			ds = this.executeDataset(sql.toString(), typeArray, argArray, true);
		}
		return ds;
	}
	/*private String findOrgan (List<String> list) {
		StringBuffer organ = new StringBuffer();
		ParameterSet pset = new ParameterSet();
		IDicCityDao dao = (DicCityDao) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		
		for (int i = 0; i < list.size(); i++) {
			String id= (String)list.get(i);
			pset.setParameter("id", id);
			DataSet dicBeanDataset = dao.query(pset);
			if(dicBeanDataset.getCount()>0){
				organ.append((String)dicBeanDataset.getRecord(0).get("fullName"));
			}
		}
		return organ.toString();
	}*/
	
	/**
	 * 打印伤残辅助器械申请
	 */
	public DataSet queryAssisDevices(ParameterSet pset){
		String applyId = (String)pset.getParameter("applyId");
		String organId = (String)pset.getParameter("organId");
		String peopleId = (String)pset.getParameter("peopleId");
		organId = organId.substring(0, 6)+"000000";
		StringBuffer sql = new StringBuffer(); 
		sql.append("SELECT C.FULL_NAME AS ORGAN_NAME, D.NAME AS PEOPLE_NAME,\n");
		sql.append("       FLOOR(MONTHS_BETWEEN(TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'),\n"); 
		sql.append("                                     'YYYY-MM-DD'),\n"); 
		sql.append("                             TO_DATE(P.BIRTHDAY, 'YYYY-MM-DD')) / 12) AS AGE,\n"); 
		sql.append("       D.ADDRESS,\n"); 
		sql.append("       (CASE D.DISABILITY_LEVEL\n"); 
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
		sql.append("        END) DISABILITY_LEVEL,\n"); 
		sql.append("       CASE D.DISABILITY_GENUS\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '在乡'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '在职'\n"); 
		sql.append("        END DISABILITY_GENUS, D.DISABILITY_NO, D.DISABILITY_CASE,\n"); 
		sql.append("       R.CHECK_INCHARGE, R.CHECK_ADVICE,\n"); 
		sql.append(" "+todate.todate("R.CHECK_APPROVE_DATE")+" CHECK_APPROVE_DATE,\n"); 
		sql.append(" "+todate.todate("R.ADUIT_APPROVE_DATE")+" ADUIT_APPROVE_DATE,\n"); 
		sql.append("       D.APPARATUS_NAME, D.APPLY_CAUSA,R.ADUIT_INCHARGE, R.ADUIT_ADVICE, D.NOTE\n"); 
		sql.append("  FROM BPT_APPLY_ASSISTIVE_DEVICES D, BASEINFO_PEOPLE P,\n"); 
		sql.append("  		(select FULL_NAME from dic_city g where g.ID = ?) c,");
		sql.append("       BPT_APPLY_ASSISTIVE_DEVICES_PR R\n"); 
		sql.append(" WHERE  D.PEOPLE_ID = P.PEOPLE_ID AND D.APPLY_ID = R.APPLY_ID\n"); 
		sql.append("   AND D.PEOPLE_ID = ?\n"); 
		sql.append("   AND D.APPLY_ID = ?\n"); 
		sql.append("   AND R.APPLY_ID = ?");
		return this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{organId,peopleId,applyId,applyId},true);
	}
	
	public DataSet queryIntroductionLetter (ParameterSet pset) {
		String peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
		sql.append(" select a.name, (case a.sex when '1' then '男' when '2' then '女' end ), a.id_card, ");
		sql.append(" a.domicile_code , a.birthday, a.work_unit_name, a.address,");
		sql.append(" b.numbering, b.identification_unit, b.introduction_unit, b.introduction_date, b.identification_date, b.agent, b.agent_phone, b.data_situation, b.note, ");
		sql.append(" c.full_name AS domicile_name");
		sql.append(" from  BASEINFO_PEOPLE a, BPT_DISABILITY_IDENTI b, DIC_CITY c ");
		sql.append(" where a.people_id = b.people_id and c.id=a.domicile_code and a.people_id = ? ");
		return this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{peopleId}, true);
	}
}
