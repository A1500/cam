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
 * @description:山东省领取定期抚恤金审批表打印
 * @author:
 * @since:2011-05-31
 * @version:1.0 
*/
 public class DependantAppPrintDao extends IPrintDao{
	 
	@Override 
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}

	@SuppressWarnings("unchecked")
	public DataSet queryData(ParameterSet pst) {
		DataSet ds = new DataSet();
		ToDate toDate = new ToDate();
		StringBuffer bf = new StringBuffer();
		bf.append("SELECT B.PHOTO_ID, B.PEOPLE_ID, B.FAMILY_ID, B.NAME,\n");
		bf.append("       (CASE B.SEX\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '男'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '女'\n"); 
		bf.append("        END) AS SEX, B.ID_CARD, B.BIRTHDAY,\n"); 
		bf.append("       (CASE B.DOMICILE_TYPE\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '农村'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '城镇'\n"); 
		bf.append("        END) AS DOMICILE_TYPE,\n"); 
		bf.append("       (CASE P.DEPENDANT_TYPE_CODE\n"); 
		bf.append("          WHEN '21' THEN\n"); 
		bf.append("           '烈士遗属'\n"); 
		bf.append("          WHEN '22' THEN\n"); 
		bf.append("           '因公牺牲军人遗属'\n"); 
		bf.append("          WHEN '23' THEN\n"); 
		bf.append("           '病故军人遗属'\n"); 
		bf.append("        END) AS DEPENDANT_TYPE,\n"); 
		bf.append("       (CASE BD.RELATIONSHIP\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '父母（抚养人）'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '子女'\n"); 
		bf.append("          WHEN '3' THEN\n"); 
		bf.append("           '配偶'\n"); 
		bf.append("          WHEN '4' THEN\n"); 
		bf.append("           '兄弟姐妹'\n"); 
		bf.append("        END) AS RELATIONSHIP, B.ADDRESS, BD.LEZSW_NAME,\n"); 
		bf.append("       (CASE BD.LEZSW_SEX\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '男'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '女'\n"); 
		bf.append("        END) AS LEZSW_SEX, BD.LEZSW_BIRTHDAY, BD.CONSCRIPT_DATE,\n"); 
		bf.append("       (BD.WORK_UNIT || ' ' || BD.POSITION) AS UNITANDPOSITION,\n"); 
		bf.append("       BD.LEZSW_APPROVE_DATE, BD.LEZSW_CERTIFICATE_ID,\n"); 
		bf.append("       (BD.DEATH_DATE || ' ' || BD.DEATH_ADDRESS || ' ' || BD.DEATH_REASON) AS DEATH_INFO,\n"); 
		bf.append("       BP.ACCEPT_ADVICE, BP.ACCEPT_INCHARGE,"+toDate.todate("BP.ACCEPT_DATE")+" AS ACCEPT_DATE, BP.COUNTIES_ADUIT_ADVICE,\n"); 
		bf.append("       BP.COUNTIES_ADUIT_INCHARGE,"+toDate.todate("BP.COUNTIES_ADUIT_APPROVE_DATE")+" AS COUNTIES_ADUIT_APPROVE_DATE,\n"); 
		bf.append("       BP.TOWN_ADUIT_ADVICE, BP.TOWN_ADUIT_INCHARGE,\n"); 
		bf.append(" "+toDate.todate("BP.TOWN_ADUIT_APPROVE_DATE")+" AS TOWN_ADUIT_APPROVE_DATE\n"); 
		bf.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE P, BPT_PEOPLE_DEPENDANT BD,\n"); 
		bf.append("       BPT_APPLY_DEPENDANT BP\n"); 
		bf.append(" WHERE BD.PEOPLE_ID = B.PEOPLE_ID\n"); 
		bf.append("   AND B.PEOPLE_ID = P.PEOPLE_ID\n"); 
		bf.append("   AND B.DEPENDANT_FLAG = '1' \n"); 
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String peopleId = (String)pst.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			bf.append(" and b.people_id =?");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		String applyId = (String)pst.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			bf.append(" and BP.people_id=b.people_id and BP.apply_id =?");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(bf.toString(),types,args, true);
		} else {
			ds = this.executeDataset(bf.toString(), true);
		}
		return  ds;
	}
	/**
	 * 优抚医院打印
	 * @param pst
	 * @return
	 */
	public DataSet printHospital(ParameterSet pst){
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT D.MENTALNUM,\n");
		sql.append("       (case D.BPT_HOSPITAL_GRADE  when '01' then '三级甲等' when '02' then '三级乙等' when '03' then '三级丙等' when '04' then '二级甲等' when '05' then '二级乙等' when '06' then '二级丙等' when '07' then '一级甲等' when '08' then '一级乙等' when '09' then '一级丙等' end ) as BPT_HOSPITAL_GRADE,\n"); 
		sql.append("       D.REGISTER_PROPERTY,\n"); 
		sql.append("       (case  D.IFPREVENTIONNET when '0' then '否' when '1' then '是'  end ) as IFPREVENTIONNET,\n"); 
		sql.append("       D.NEW_ART_BUSINESS,\n"); 
		sql.append("       D.INCOME,\n"); 
		sql.append("       (case D.UNITS_NATURE when '1' then '全额拨款事业单位' when '2' then '差额拨款事业单位'  end ) as UNITS_NATURE ,\n"); 
		sql.append("       D.OFFICIAL_FUNDS,\n"); 
		sql.append("       D.ID,\n"); 
		sql.append("       D.SOCIETY_NUM,\n"); 
		sql.append("       D.MOD_ID,\n"); 
		sql.append("       D.FLOOR_AREA,\n"); 
		sql.append("       (case D.ADMINISTRATIVE_LEVEL when '1' then '正县' when '2' then '副县' when '3' then '正科' when '4' then '副科'  end) as ADMINISTRATIVE_LEVEL ,\n"); 
		sql.append("       D.POSTCODE,\n"); 
		sql.append("       D.INTERMEDIATE_TITLE_NUM,\n"); 
		sql.append("       D.ADD_BED,\n"); 
		sql.append("       D.REAR_SERVICE_NUM,\n"); 
		sql.append("       D.REG_TIME,\n"); 
		sql.append("       D.YEARS,\n"); 
		sql.append("       D.YEAR_WORKER_NUM,\n"); 
		sql.append("       D.TEL_CONTACT,\n"); 
		sql.append("       D.HOSPITAL_ID,\n"); 
		sql.append("       D.OTHER_FUNDS,\n"); 
		sql.append("       D.PERSON_SECTION,\n"); 
		sql.append("       D.ALLYEAR_OUTPATIENTS,\n"); 
		sql.append("       D.TENABOVE_DEVICE,\n"); 
		sql.append("       D.HOSPITALIZATION,\n"); 
		sql.append("       D.TREATMENTALNUM,\n"); 
		sql.append("       D.MAIM_NUM,\n"); 
		sql.append("       D.TENBELOW_DEVICE,\n"); 
		sql.append("       D.UNIT_FULLNAME,\n"); 
		sql.append("       D.TELCONSULTATION,\n"); 
		sql.append("       D.NUMINYEAR,\n"); 
		sql.append("       D.RESORT,\n"); 
		sql.append("       D.PRIMARY_TITLE_NUM,\n"); 
		sql.append("       D.CENTRAL_FUNDS,\n"); 
		sql.append("       D.PLACE_FUNDS,\n"); 
		sql.append("       D.MOBILEMEDICAL,\n"); 
		sql.append("       D.OTHERILL_HOMETOWN,\n"); 
		sql.append("       D.SENIOR_TITLE_NUM,\n"); 
		sql.append("       D.REG_ID,\n"); 
		sql.append("       D.ALLYEAR_INHOSPITAL,\n"); 
		sql.append("       D.NEWEQUIPMENT,\n"); 
		sql.append("       D.SERVICE,\n"); 
		sql.append("       C.NAME AS DOMICILE_CODE,\n"); 
		sql.append("       D.PERSONNEL_FUNDS,\n"); 
		sql.append("       D.PSYCHOSIS_HOMETOWN,\n"); 
		sql.append("       D.FORMATION_BED,\n"); 
		sql.append("       D.MOD_TIME,\n"); 
		sql.append("       D.MAILING_ADDRESS,\n"); 
		sql.append("       D.NUMENDYEAR,\n"); 
		sql.append("       D.BPT_LIVE_FUNDS,\n"); 
		sql.append("       (case D.BPT_HOSPITAL_SORT when '1' then '荣誉军人康复医院' when '2' then '复员军人慢性病疗养院' when '3' then '复员退伍军人精神病医院'  end ) as BPT_HOSPITAL_SORT,\n"); 
		sql.append("       D.THREEW_NUM,\n"); 
		sql.append("       D.CREATION_DATE,\n"); 
		sql.append("       (case D.BPT_HOSPITAL_BUSINTYPE when '1' then '综合' when '2' then '专科'  end ) as BPT_HOSPITAL_BUSINTYPE,\n"); 
		sql.append("       D.YEAR_BPT_NUM,\n"); 
		sql.append("       D.NOTE,\n"); 
		sql.append("       D.PREPARE_NUM,\n"); 
		sql.append("       D.IMMOBILISATIONS,\n"); 
		sql.append("       D.BUSINESS_AREA,\n"); 
		sql.append("       D.UNIT_INTRODUCE,\n"); 
		sql.append("       D.NEWEXPANSION,\n"); 
		sql.append("       D.YEAR_ACTUAL_BED,\n"); 
		sql.append("       D.BPT_MEDICAL_FUNDS,\n"); 
		sql.append("       L.MOD_TIME,\n"); 
		sql.append("       L.TEL_CONTACT AS TEL_CONTACTL,\n"); 
		sql.append("       L.LEGAL_ID,\n"); 
		sql.append("       L.HOSPITAL_DETAIL_ID,\n"); 
		sql.append("       L.REG_ID,\n"); 
		sql.append("       L.NOTE as NOTEL,\n"); 
		sql.append("       (case L.SEX  when '1' then '男' when '2' then '女' end ) as SEX,\n"); 
		sql.append("       L.MOD_ID,\n"); 
		sql.append("       (case L.CULTURE_DEGREE when '10' then '研究生' when '20' then '大学本科' when '30' then '大学专科和专科学校' when '40' then '中等专业学校或中等技术学校' when '50' then '技工学校' when '60' then '高中' when '70' then '初中' when '80' then '小学' when '90' then '文盲或半文盲'  end ) as CULTURE_DEGREE,\n"); 
		sql.append("       (case L.MAJOR_JOB  when '1' then '无' when '2' then '初级职称' when '3' then '中级职称' when '4' then '副高职称' when '5' then '高级职称' end ) as MAJOR_JOB,\n"); 
		sql.append("       L.ID_CARD,\n"); 
		sql.append("       L.LEARN_MAJOR,\n"); 
		sql.append("       (case L.POLITICALLANDSCAPE  when '01' then '中国共产党党员' when '02' then '中国共产党预备党员' when '03' then '中国国民党革命委员会会员' when '04' then '中国民主同盟盟员' when '05' then '中国民主建国会会员' when '06' then '中国民主促进会会员' when '07' then '中国农工民主党党员' when '08' then '中国致公党党员' when '09' then '九三学社社员' when '10' then '台湾民主自治同盟盟员' when '11' then '无党派民主人士' when '12' then '群众' end) as POLITICALLANDSCAPE,\n"); 
		sql.append("       N.NAME AS NATION,\n"); 
		sql.append("       L.REG_TIME,\n"); 
		sql.append("       L.NAME,\n"); 
		sql.append("       L.BIRTHDAY\n"); 
		sql.append("  FROM BPT_HOSPITAL_DETAIL D,BPT_HOSPITAL_LEGAL L, DIC_CITY C,DIC_NATION N\n"); 
		sql.append(" WHERE D.Id=l.HOSPITAL_DETAIL_ID AND L.NATION= N.CODE AND D.DOMICILE_CODE = C.ID");

		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String peopleId = (String)pst.getParameter("id");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and D.id =?");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return  ds;
	}
	/**
	 * 光荣院打印
	 * @param pst
	 * @return
	 */
	public DataSet printGlorious(ParameterSet pst){
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT D.VETERANE_NUM,\n");
		sql.append("       D.REGISTER_PROPERTY,\n"); 
		sql.append("      (case D.UNITS_NATURE when '1' then '全额拨款事业单位' when '2' then '差额拨款事业单位'  end ) as UNITS_NATURE ,\n"); 
		sql.append("       D.OFFICIAL_FUNDS,\n"); 
		sql.append("       (case D.PROPERTIES  when '1' then '国家办' when '2' then '集体办' when '3' then '民办'  end) as PROPERTIES,\n"); 
		sql.append("       D.ID,\n"); 
		sql.append("       D.MOD_ID,\n"); 
		sql.append("       D.FLOOR_AREA,\n"); 
		sql.append("       (case D.ADMINISTRATIVE_LEVEL when '1' then '正县' when '2' then '副县' when '3' then '正科' when '4' then '副科'  end) as ADMINISTRATIVE_LEVEL ,\n"); 
		sql.append("       D.POSTCODE,\n"); 
		sql.append("       D.INTERMEDIATE_TITLE_NUM,\n"); 
		sql.append("       D.REG_TIME,\n"); 
		sql.append("       D.YEARS,\n"); 
		sql.append("       D.COUNTYFUNDS,\n"); 
		sql.append("       D.YEAR_WORKER_NUM,\n"); 
		sql.append("       D.TEL_CONTACT,\n"); 
		sql.append("       D.THREE_CATEGORY,\n"); 
		sql.append("       D.OTHER_FUNDS,\n"); 
		sql.append("       D.PERSON_SECTION,\n"); 
		sql.append("       D.MAIM_NUM,\n"); 
		sql.append("       D.UNIT_FULLNAME,\n"); 
		sql.append("       D.CITYFUNDS,\n"); 
		sql.append("       D.PRIMARY_TITLE_NUM,\n"); 
		sql.append("       D.CENTRAL_FUNDS,\n"); 
		sql.append("       D.CARE_PEOPLE,\n"); 
		sql.append("       D.PLACE_FUNDS,\n"); 
		sql.append("       D.GLORIOUS_ID,\n"); 
		sql.append("       D.OTHER_NUM,\n"); 
		sql.append("       (case D.BUILD_STATE  when '1' then '建成并使用' when '2' then '建成未使用' when '3' then '在建'  end) as BUILD_STATE ,\n"); 
		sql.append("       D.BED_NUM,\n"); 
		sql.append("       D.SENIOR_TITLE_NUM,\n"); 
		sql.append("       D.CARE_ROTATION,\n"); 
		sql.append("       D.REG_ID,\n"); 
		sql.append("        (case  D.APPROVAL when '0' then '否' when '1' then '是'  end ) as APPROVAL,\n"); 
		sql.append("       (case  D.BUILDINGAPPROACH  when '1' then '合建' when '2' then '单建' end) as BUILDINGAPPROACH,\n"); 
		sql.append("       c.name as DOMICILE_CODE,\n"); 
		sql.append("       D.PERSONNEL_FUNDS,\n"); 
		sql.append("       D.MOD_TIME,\n"); 
		sql.append("       D.MAILING_ADDRESS,\n"); 
		sql.append("       D.THREE_RED_NUM,\n"); 
		sql.append("       D.BPT_LIVE_FUNDS,\n"); 
		sql.append("       D.PROVINCEFUNDS,\n"); 
		sql.append("       D.THREEW_NUM,\n"); 
		sql.append("       D.CREATION_DATE,\n"); 
		sql.append("       D.PREPARE_NUM,\n"); 
		sql.append("       D.NOTE,\n"); 
		sql.append("       D.IMMOBILISATIONS,\n"); 
		sql.append("       D.BUSINESS_AREA,\n"); 
		sql.append("       D.UNIT_INTRODUCE,\n"); 
		sql.append("       D.ADOPT_NUM,\n"); 
		sql.append("       D.BPT_MEDICAL_FUNDS,\n"); 
		sql.append("       D.DEMOBILIZE_NUM,\n"); 
		sql.append("       L.MOD_TIME,\n"); 
		sql.append("       L.TEL_CONTACT AS TEL_CONTACTL,\n"); 
		sql.append("       L.LEGAL_ID,\n"); 
		sql.append("       L.NOTE AS NOTEL,\n"); 
		sql.append("       L.REG_ID,\n"); 
		sql.append("       (case L.SEX  when '1' then '男' when '2' then '女' end ) as SEX,\n"); 
		sql.append("       L.MOD_ID,\n"); 
		sql.append("      (case L.CULTURE_DEGREE when '10' then '研究生' when '20' then '大学本科' when '30' then '大学专科和专科学校' when '40' then '中等专业学校或中等技术学校' when '50' then '技工学校' when '60' then '高中' when '70' then '初中' when '80' then '小学' when '90' then '文盲或半文盲'  end ) as CULTURE_DEGREE,\n"); 
		sql.append("      (case L.MAJOR_JOB  when '1' then '无' when '2' then '初级职称' when '3' then '中级职称' when '4' then '副高职称' when '5' then '高级职称' end ) as MAJOR_JOB,\n"); 
		sql.append("       L.ID_CARD,\n"); 
		sql.append("       L.LEARN_MAJOR,\n"); 
		sql.append("       L.GLORIOUS_DETAIL_ID,\n"); 
		sql.append("       N.NAME as NATION,\n"); 
		sql.append("       L.REG_TIME,\n"); 
		sql.append("       L.NAME,\n"); 
		sql.append("       L.BIRTHDAY\n"); 
		sql.append("  FROM BPT_GLORIOUS_DETAIL D,BPT_GLORIOUS_LEGAL L, DIC_CITY C,DIC_NATION N\n"); 
		sql.append(" WHERE D.Id=L.Glorious_Detail_Id AND L.NATION= N.CODE AND D.DOMICILE_CODE = C.ID");

		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String peopleId = (String)pst.getParameter("id");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and D.id =?");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return  ds;
	}
	/**
	 * 烈士纪念物打印
	 * @param pst
	 * @return
	 */
	public DataSet printMartyrBuildings(ParameterSet pst){
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT B.AMERICANA_NUM,\n");
		sql.append("       (case B.RED_SCENIC_SPOTS  when '0' then '否' when '1' then '是'  end) as RED_SCENIC_SPOTS,\n"); 
		sql.append("       B.SHOW_MARTYRS_NUM,\n"); 
		sql.append("       B.REGISTER_PROPERTY,\n"); 
		sql.append("       (CASE B.PATRIOTIC_EDUCATION_BASE  when '0' then '否' when '1' then '是'  end) AS PATRIOTIC_EDUCATION_BASE,\n"); 
		sql.append("       B.SENIOR_TITLE_NUM,\n"); 
		sql.append("      (case B.UNITS_NATURE when '1' then '全额拨款事业单位' when '2' then '差额拨款事业单位'  end ) as UNITS_NATURE ,\n"); 
		sql.append("       B.OFFICIAL_FUNDS,\n"); 
		sql.append("       B.REG_ID,\n"); 
		sql.append("       B.MOD_ID,\n"); 
		sql.append("       B.FLOOR_AREA,\n"); 
		sql.append("       (case B.ADMINISTRATIVE_LEVEL when '1' then '正县' when '2' then '副县' when '3' then '正科' when '4' then '副科'  end) as ADMINISTRATIVE_LEVEL ,\n"); 
		sql.append("       B.POSTCODE,\n"); 
		sql.append("       B.INTERMEDIATE_TITLE_NUM,\n"); 
		sql.append("       B.DOMICILE_CODE,\n"); 
		sql.append("       B.REG_TIME,\n"); 
		sql.append("       B.PERSONNEL_FUNDS,\n"); 
		sql.append("       B.MOD_TIME,\n"); 
		sql.append("       B.MAILING_ADDRESS,\n"); 
		sql.append("       B.BURIAL_MARTYRS_NUM,\n"); 
		sql.append("       B.YEAR_WORKER_NUM,\n"); 
		sql.append("       B.TEL_CONTACT,\n"); 
		sql.append("       B.OTHER_FUNDS,\n"); 
		sql.append("       B.PERSON_SECTION,\n"); 
		sql.append("       B.RECEPTION_LOOKED_NUM,\n"); 
		sql.append("       B.CREATION_DATE,\n"); 
		sql.append("       B.NOTE,\n"); 
		sql.append("       B.PREPARE_NUM,\n"); 
		sql.append("       B.PROTECTION_UNIT,\n"); 
		sql.append("       B.UNIT_FULLNAME,\n"); 
		sql.append("       B.IMMOBILISATIONS,\n"); 
		sql.append("       B.BUSINESS_AREA,\n"); 
		sql.append("       B.UNIT_INTRODUCE,\n"); 
		sql.append("       B.PRIMARY_TITLE_NUM,\n"); 
		sql.append("       B.CENTRAL_FUNDS,\n"); 
		sql.append("       B.NOTICE_DATE,\n"); 
		sql.append("       B.MARTYR_FACILITY_NUM,\n"); 
		sql.append("       B.PLACE_FUNDS,\n"); 
		sql.append("       B.MBUILDING_ID,\n"); 
		sql.append("       L.MOD_TIME,\n"); 
		sql.append("       L.TEL_CONTACT as TEL_CONTACTL,\n"); 
		sql.append("       L.LEGAL_ID,\n"); 
		sql.append("       L.NOTE as NOTEL,\n"); 
		sql.append("       L.REG_ID,\n"); 
		sql.append("       L.ID_CORD,\n"); 
		sql.append("       L.SEX,\n"); 
		sql.append("       L.MOD_ID,\n"); 
		sql.append("       L.CULTURE_DEGREE,\n"); 
		sql.append("       L.MAJOR_JOB,\n"); 
		sql.append("       L.LEARN_MAJOR,\n"); 
		sql.append("       N.NAME as NATION,\n"); 
		sql.append("       L.REG_TIME,\n"); 
		sql.append("       L.MBUILDING_ID,\n"); 
		sql.append("       L.NAME,\n"); 
		sql.append("       L.BIRTHDAY\n"); 
		sql.append("  FROM BPT_MARTYR_BUILDINGS B,BPT_MARTYR_BUILDINGS_LEGAL L,DIC_NATION N\n"); 
		sql.append(" WHERE B.MBUILDING_ID=L.Mbuilding_Id AND L.NATION= N.CODE ");

		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String peopleId = (String)pst.getParameter("mbuildingId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and B.MBUILDING_ID =?");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return  ds;
	}
}
