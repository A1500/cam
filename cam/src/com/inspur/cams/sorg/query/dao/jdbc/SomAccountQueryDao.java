package com.inspur.cams.sorg.query.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.query.dao.ISomAccountQueryDao;

public class SomAccountQueryDao extends EntityDao<SomOrgan> implements ISomAccountQueryDao {
	@SuppressWarnings("unchecked")
	protected Class getEntityClass() {
		return SomOrgan.class;
	}

	/**
	 * 查询社团台帐
	 */
	public DataSet queryGroupAccount(ParameterSet pset) {
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		typeList.add(Types.VARCHAR);
		List<Object> objList = new ArrayList<Object>();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		objList.add(morgArea);
		sql.append("SELECT A.REG_DATE ,	--登记时间													\n");
		sql.append("       A.MORG_NAME , --登记部门													\n");
		sql.append("       A.SORG_CODE , --部门登记证号												\n");
		sql.append("       A.ORGAN_CODE , --组织机构代码												\n");
		sql.append("       '' t1,  --部门交换码															\n");
		sql.append("       A.CN_NAME,  --单位名称														\n");
		sql.append("       A.LEGAL_PEOPLE,  --法定代表人												\n");
		sql.append("       A.RESIDENCE,  --地址														\n");
		sql.append("       A.SORG_POST,  --邮编														\n");
		sql.append("       A.SORG_PHONE,  --电话														\n");
		sql.append("       A.BUS_SCOPE,  --行业分类代码												\n");
		sql.append("       '' t2,  --变动类型代码															\n");
		sql.append("       '' t3,  --变动时间															\n");
		sql.append("       NVL(B.COUNT, 0)  BRANCH_COUNT, --分支机构									\n");
		sql.append("       NVL(A.ENGAGED_NUM,0) ENGAGED_NUM,  --年末从业人数												\n");
		sql.append("       '' t4,  --年末从业人数女														\n");
		sql.append("       NVL(H.PARTY_PRACTITIONER_NUM,0) PARTY_PRACTITIONER_NUM,  --年末从业人数党员								\n");
		sql.append("       '' t5,  --受教育程度大学专科													\n");
		sql.append("       '' t6,  --受教育程度大学本科及以上												\n");
		sql.append("       '' t7,  --职业资格水平助理社会工作师												\n");
		sql.append("       '' t8,  --职业资格水平社会工作师													\n");
		sql.append("       '' t9,  --年龄结构35岁及以下													\n");
		sql.append("       '' t10,  --年龄结构36岁至45岁													\n");
		sql.append("       '' t11,  --年龄结构46岁至55岁													\n");
		sql.append("       '' t12,  --年龄结构56岁及以上													\n");
		sql.append("       NVL(C.DUTYCOUNT, 0)  DUTY_COUNT, --民间组织负责人数							\n");
		sql.append("       NVL(D.DUTYFEMALECOUNT, 0)  DUTY_FEMALE_COUNT, --民间组织负责人数女			\n");
		sql.append("       NVL(A.UNITS_NUM+A.PEOPLE_NUM,0) TOTAL_NUM, --会员总数								\n");
		sql.append("       NVL(A.UNITS_NUM,0) UNITS_NUM, --团体会员													\n");
		sql.append("       NVL(A.PEOPLE_NUM,0) PEOPLE_NUM, --个人会员													\n");
		sql.append("       NVL(P.SERVANT_PRO_NUM+P.SERVANT_CITY_NUM+P.SERVANT_TOWN_NUM,0) SERVANT_TOTAL_NUM, --党政机关领导干部兼任领导人数			\n");
		sql.append("       '' t13,  --执行会计制度															\n");
		sql.append("       NVL(I.FA_PRIME_COST_E,0) FA_PRIME_COST_E,  --固定资产原价											\n");
		sql.append("       NVL(I.FA_NET_VALUE_S,0) FA_NET_VALUE_S,  --上年结余												\n");
		sql.append("       NVL(I.FA_ACCUMULATED_DEPRECIATION_E - I.FA_ACCUMULATED_DEPRECIATION_S,0) FA_ACCUMULATED_DEPRECIATION,  --本年折旧		\n");
		sql.append("       NVL(F.INCOME_SUM_TY_SUM,0) INCOME_SUM_TY_SUM,  --营业收入											\n");
		sql.append("       NVL(F.COST_SUM_TY_SUM,0) COST_SUM_TY_SUM,  --营业成本												\n");
		sql.append("       NVL(F.TAXES_TY_SUM,0) TAXES_TY_SUM,  --营业税金及附加											\n");
		sql.append("       '' t14,  --销售费用															\n");
		sql.append("       NVL(F.MANAGE_COST_TY_SUM,0) MANAGE_COST_TY_SUM,  --管理费用											\n");
		sql.append("       '' t15,  --管理费用税金															\n");
		sql.append("       '' t16,  --管理费用差旅费														\n");
		sql.append("       '' t17,  --财务费用															\n");
		sql.append("       '' t18,  --财务费用利息支出														\n");											
		sql.append("       '' t19,  --公允价值变动收益														\n");
		sql.append("       NVL(F.INV_INCOME_TY_SUM,0) INV_INCOME_TY_SUM,  --投资收益											\n");
		sql.append("       '' t20,  --营业利润															\n");
		sql.append("       NVL(J.COMM_EXP_PER,0) COMM_EXP_PER,  --应付职工薪酬												\n");
		sql.append("       --本年度收入合计 INCOME_SUM_TY_SUM											\n");
		sql.append("       NVL(F.GOV_GRANTS_TY_SUM,0) GOV_GRANTS_TY_SUM,  --本年度收入合计事业收入								\n");
		sql.append("       '' t21,  --本年度收入合计经营收入													\n");
		sql.append("       NVL(F.DONATION_INCOME_TY_SUM,0) DONATION_INCOME_TY_SUM,  --本年度收入合计捐赠收入							\n");
		sql.append("       NVL(F.DUES_INCOME_TY_SUM,0) DUES_INCOME_TY_SUM,  --本年度收入合计会费收入								\n");
		sql.append("       --本年支出合计	COST_SUM_TY_SUM												\n");
		sql.append("       --本年支出合计工资福利支出 COMM_EXP_PER										\n");
		sql.append("       '' t22,  --本年支出合计商品和服务支出												\n");
		sql.append("       '' t23,  --商品和服务支出福利费													\n");
		sql.append("       '' t24,  --商品和服务支出劳务费													\n");
		sql.append("       '' t25,  --商品和服务支出取暖费													\n");
		sql.append("       '' t26,  --商品和服务支出差旅费													\n");
		sql.append("       '' t27,  --对个人和家庭补助支出													\n");
		sql.append("       '' t28,  --对个人和家庭补助支出助学金												\n");
		sql.append("       '' t29,  --对个人和家庭补助支出抚恤金												\n");
		sql.append("       '' t30,  --对个人和家庭补助支出生活补助											\n");
		sql.append("       NVL(F.ASSETS_CHANGE_TY_SUM,0) ASSETS_CHANGE_TY_SUM,  --收支结余										\n");
		sql.append("       NVL(I.CL_TAS_PAYABLE_E,0) CL_TAS_PAYABLE_E,  --经营税金											\n");
		sql.append("       --本年费用合计 COST_SUM_TY_SUM												\n");
		sql.append("       NVL(F.BUSINESS_COST_TY_SUM,0) BUSINESS_COST_TY_SUM,  --本年费用合计业务活动成本							\n");
		sql.append("       NVL(F.STAFF_COST_TY_SUM,0) STAFF_COST_TY_SUM,  --业务活动成本人员费用									\n");
		sql.append("       NVL(F.RUNNING_COST_TY_SUM,0) RUNNING_COST_TY_SUM,  --业务活动成本日常费用								\n");
		sql.append("       NVL(F.DEPRECIATION_ASSETS_TY_SUM,0) DEPRECIATION_ASSETS_TY_SUM,  --业务活动成本固定资产折旧						\n");
		sql.append("       --业务活动成本税费 TAXES_TY_SUM												\n");
		sql.append("       --本年费用合计管理费用 MANAGE_COST_TY_SUM									\n");
		sql.append("       '' t31,  --管理费用人员费用														\n");
		sql.append("       '' t32,  --管理费用日常费用														\n");
		sql.append("       '' t33,  --管理费用固定资产折旧													\n");
		sql.append("       '' t34,  --管理费用税费															\n");
		sql.append("       --净资产变动额 ASSETS_CHANGE_TY_SUM											\n");
		sql.append("       NVL(L.CURRENT_MONEY,0) CURRENT_MONEY,--本年捐赠现金收入 CURRENT_MONEY												\n");
		sql.append("       NVL(K.CURRENT_PRACTICALI,0) CURRENT_PRACTICALI,  --本年捐赠实物折价									\n");
		sql.append("       --会费收入 DUES_INCOME_TY_SUM												\n");
		sql.append("       G.BORG_NAME,  --业务主管部门												\n");
		sql.append("       NVL(N.VOLUNTER_NUM,0) VOLUNTER_NUM,	--志愿者数												\n");
		sql.append("       DECODE(H.IF_BUILD_PARTY,'1','是','0','否','否') IF_BUILD_PARTY,  --是否建立党组织											\n");
		sql.append("       NVL(O.PUBLICATION_NUM+O.INNER_PUBLICATION_NUM,0) PUBLICATION_TOTAL_NUM,  --出版物数									\n");
		sql.append("       E.CHECK_TIME  --年检时间													\n");
		sql.append("  FROM SOM_ORGAN A																\n");
		sql.append("	/*查询分支机构数*/																\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(MAIN_SORG_CODE)  COUNT, MAIN_SORG_CODE			\n");
		sql.append("	               FROM SOM_ORGAN												\n");
		sql.append("	              WHERE SORG_TYPE = 'S'											\n");
		sql.append("	                AND SORG_STATUS = '22'										\n");
		sql.append("	              GROUP BY MAIN_SORG_CODE) B									\n");
		sql.append("	    ON B.MAIN_SORG_CODE = A.SORG_CODE										\n");
		sql.append("	/*民间组织负责人数*/															\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(SORG_ID)  DUTYCOUNT, SORG_ID						\n");
		sql.append("	               FROM SOM_DUTY												\n");
		sql.append("	              WHERE REG_STATUS = '1'										\n");
		sql.append("	                AND IF_SERVE = '1'											\n");
		sql.append("	              GROUP BY SORG_ID) C											\n");
		sql.append("	    ON C.SORG_ID = A.SORG_ID												\n");
		sql.append("	/*民间组织负责人数女*/															\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(SORG_ID)  DUTYFEMALECOUNT, SORG_ID				\n");
		sql.append("	               FROM SOM_DUTY, SOM_PEOPLE									\n");
		sql.append("	              WHERE REG_STATUS = '1'										\n");
		sql.append("	                AND IF_SERVE = '1'											\n");
		sql.append("	                AND SOM_PEOPLE.PEOPLE_ID = SOM_DUTY.PEOPLE_ID				\n");
		sql.append("	                AND SOM_PEOPLE.SEX = '2'									\n");
		sql.append("	              GROUP BY SORG_ID) D											\n");
		sql.append("	    ON D.SORG_ID = A.SORG_ID												\n");
		sql.append("	/*年检基本表*/																\n");
		sql.append("	  LEFT JOIN (SELECT SORG_CODE, SORG_TYPE, TASK_CODE, BORG_NAME, CHECK_TIME	\n");
		sql.append("	               FROM SOM_CHECK E1											\n");
		sql.append("	              WHERE BATCH_YEAR = (SELECT MAX(BATCH_YEAR)					\n");
		sql.append("	                                    FROM SOM_CHECK E2						\n");
		sql.append("	                                   WHERE E1.SORG_CODE = E2.SORG_CODE		\n");
		sql.append("	                                   GROUP BY SORG_CODE)) E					\n");
		sql.append("	    ON E.SORG_CODE = A.SORG_CODE											\n");
		sql.append("	   AND E.SORG_TYPE = A.SORG_TYPE											\n");				
		sql.append("     /*业务活动表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_BUSINESS_ACTIVITY F									\n");
		sql.append("	    ON F.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*业务主管单位表*/																\n");
		sql.append("	  LEFT JOIN SOM_BUSINESS_ORGAN G											\n");
		sql.append("	    ON G.BORG_CODE = A.BORG_NAME											\n");
		sql.append("	/*党建表*/																	\n");
		sql.append("	  LEFT JOIN SOM_CHECK_PARTY H												\n");
		sql.append("	    ON H.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*资产负债表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_BALANCE_SHEET I										\n");
		sql.append("	    ON I.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*公益支出情况表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_EXPENDITURE J											\n");
		sql.append("	    ON J.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*接受捐赠情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CONTRIBUTE K												\n");
		sql.append("	    ON K.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	   AND K.IF_OPEN = '0'														\n");
		sql.append("	/*公开募捐情况表*/																\n");
		sql.append("	  LEFT JOIN SOM_CONTRIBUTE L												\n");
		sql.append("	    ON L.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	   AND K.IF_OPEN = '1'														\n");
		sql.append("	/*公益活动情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_PUBLIC_BENEFIT M										\n");
		sql.append("	    ON M.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*工作人员情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_WORKER N												\n");
		sql.append("	    ON N.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*举办刊物情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_PUBLICATION O											\n");
		sql.append("	    ON O.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*理事会情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_COUNCIL P												\n");
		sql.append("	    ON P.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	 WHERE A.IF_BRANCH = '0'													\n");
		sql.append("	   AND A.SORG_TYPE = 'S'													\n");
		sql.append("	   AND A.SORG_STATUS = '22'													\n");
		sql.append("	   AND A.MORG_AREA LIKE ?													\n");		
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		}else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}

	/**
	 * 查询民非台帐
	 */
	public DataSet queryUngovAccount(ParameterSet pset) {
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		typeList.add(Types.VARCHAR);
		List<Object> objList = new ArrayList<Object>();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		objList.add(morgArea);
		sql.append("SELECT A.REG_DATE ,	--登记时间													\n");
		sql.append("       A.MORG_NAME , --登记部门													\n");
		sql.append("       A.SORG_CODE , --部门登记证号												\n");
		sql.append("       A.ORGAN_CODE , --组织机构代码												\n");
		sql.append("       '' t1,  --部门交换码															\n");
		sql.append("       A.CN_NAME,  --单位名称														\n");
		sql.append("       A.LEGAL_PEOPLE,  --法定代表人												\n");
		sql.append("       A.RESIDENCE,  --地址														\n");
		sql.append("       A.SORG_POST,  --邮编														\n");
		sql.append("       A.SORG_PHONE,  --电话														\n");
		sql.append("       A.BUS_SCOPE,  --行业分类代码												\n");
		sql.append("       '' t2,  --变动类型代码															\n");
		sql.append("       '' t3,  --变动时间															\n");
		sql.append("       NVL(B.COUNT, 0)  BRANCH_COUNT, --分支机构									\n");
		sql.append("       NVL(C.DUTYCOUNT, 0)  DUTY_COUNT, --民间组织负责人数							\n");
		sql.append("       NVL(D.DUTYFEMALECOUNT, 0)  DUTY_FEMALE_COUNT, --民间组织负责人数女			\n");
		sql.append("       NVL(A.ENGAGED_NUM,0) ENGAGED_NUM,  --年末从业人数												\n");
		sql.append("       '' t4,  --年末从业人数女														\n");
		sql.append("       NVL(H.PARTY_PRACTITIONER_NUM,0) PARTY_PRACTITIONER_NUM,  --年末从业人数党员								\n");
		sql.append("       '' t5,  --受教育程度大学专科													\n");
		sql.append("       '' t6,  --受教育程度大学本科及以上												\n");
		sql.append("       '' t7,  --职业资格水平助理社会工作师												\n");
		sql.append("       '' t8,  --职业资格水平社会工作师													\n");
		sql.append("       '' t9,  --年龄结构35岁及以下													\n");
		sql.append("       '' t10,  --年龄结构36岁至45岁													\n");
		sql.append("       '' t11,  --年龄结构46岁至55岁													\n");
		sql.append("       '' t12,  --年龄结构56岁及以上													\n");
		sql.append("       '' t13,  --执行会计制度															\n");
		sql.append("       NVL(I.FA_PRIME_COST_E,0) FA_PRIME_COST_E,  --固定资产原价											\n");
		sql.append("       NVL(I.FA_NET_VALUE_S,0) FA_NET_VALUE_S,  --上年结余												\n");
		sql.append("       NVL(I.FA_ACCUMULATED_DEPRECIATION_E - I.FA_ACCUMULATED_DEPRECIATION_S,0) FA_ACCUMULATED_DEPRECIATION,  --本年折旧		\n");
		sql.append("       NVL(F.INCOME_SUM_TY_SUM,0) INCOME_SUM_TY_SUM,  --营业收入											\n");
		sql.append("       NVL(F.COST_SUM_TY_SUM,0) COST_SUM_TY_SUM,  --营业成本												\n");
		sql.append("       NVL(F.TAXES_TY_SUM,0) TAXES_TY_SUM,  --营业税金及附加											\n");
		sql.append("       '' t14,  --销售费用															\n");
		sql.append("       NVL(F.MANAGE_COST_TY_SUM,0) MANAGE_COST_TY_SUM,  --管理费用											\n");
		sql.append("       '' t15,  --管理费用税金															\n");
		sql.append("       '' t16,  --管理费用差旅费														\n");
		sql.append("       '' t17,  --财务费用															\n");
		sql.append("       '' t18,  --财务费用利息支出														\n");											
		sql.append("       '' t19,  --公允价值变动收益														\n");
		sql.append("       NVL(F.INV_INCOME_TY_SUM,0) INV_INCOME_TY_SUM,  --投资收益											\n");
		sql.append("       '' t20,  --营业利润															\n");
		sql.append("       NVL(J.COMM_EXP_PER,0) COMM_EXP_PER,  --应付职工薪酬												\n");
		sql.append("       --本年度收入合计 INCOME_SUM_TY_SUM											\n");
		sql.append("       NVL(F.GOV_GRANTS_TY_SUM,0) GOV_GRANTS_TY_SUM,  --本年度收入合计事业收入								\n");
		sql.append("       '' t21,  --本年度收入合计经营收入													\n");
		sql.append("       NVL(F.DONATION_INCOME_TY_SUM,0) DONATION_INCOME_TY_SUM,  --本年度收入合计捐赠收入							\n");
		sql.append("       NVL(F.DUES_INCOME_TY_SUM,0) DUES_INCOME_TY_SUM,  --本年度收入合计会费收入								\n");
		sql.append("       --本年支出合计	COST_SUM_TY_SUM												\n");
		sql.append("       --本年支出合计工资福利支出 COMM_EXP_PER										\n");
		sql.append("       '' t22,  --本年支出合计商品和服务支出												\n");
		sql.append("       '' t23,  --商品和服务支出福利费													\n");
		sql.append("       '' t24,  --商品和服务支出劳务费													\n");
		sql.append("       '' t25,  --商品和服务支出取暖费													\n");
		sql.append("       '' t26,  --商品和服务支出差旅费													\n");
		sql.append("       '' t27,  --对个人和家庭补助支出													\n");
		sql.append("       '' t28,  --对个人和家庭补助支出助学金												\n");
		sql.append("       '' t29,  --对个人和家庭补助支出抚恤金												\n");
		sql.append("       '' t30,  --对个人和家庭补助支出生活补助											\n");
		sql.append("       NVL(F.ASSETS_CHANGE_TY_SUM,0) ASSETS_CHANGE_TY_SUM,  --收支结余										\n");
		sql.append("       NVL(I.CL_TAS_PAYABLE_E,0) CL_TAS_PAYABLE_E,  --经营税金											\n");
		sql.append("       --本年费用合计 COST_SUM_TY_SUM												\n");
		sql.append("       NVL(F.BUSINESS_COST_TY_SUM,0) BUSINESS_COST_TY_SUM,  --本年费用合计业务活动成本							\n");
		sql.append("       NVL(F.STAFF_COST_TY_SUM,0) STAFF_COST_TY_SUM,  --业务活动成本人员费用									\n");
		sql.append("       NVL(F.RUNNING_COST_TY_SUM,0) RUNNING_COST_TY_SUM,  --业务活动成本日常费用								\n");
		sql.append("       NVL(F.DEPRECIATION_ASSETS_TY_SUM,0) DEPRECIATION_ASSETS_TY_SUM,  --业务活动成本固定资产折旧						\n");
		sql.append("       --业务活动成本税费 TAXES_TY_SUM												\n");
		sql.append("       --本年费用合计管理费用 MANAGE_COST_TY_SUM									\n");
		sql.append("       '' t31,  --管理费用人员费用														\n");
		sql.append("       '' t32,  --管理费用日常费用														\n");
		sql.append("       '' t33,  --管理费用固定资产折旧													\n");
		sql.append("       '' t34,  --管理费用税费															\n");
		sql.append("       --净资产变动额 ASSETS_CHANGE_TY_SUM											\n");
		sql.append("       NVL(L.CURRENT_MONEY,0) CURRENT_MONEY,--本年捐赠现金收入 CURRENT_MONEY												\n");
		sql.append("       NVL(K.CURRENT_PRACTICALI,0) CURRENT_PRACTICALI,  --本年捐赠实物折价									\n");
		sql.append("       --会费收入 DUES_INCOME_TY_SUM												\n");
		sql.append("       G.BORG_NAME,  --业务主管部门												\n");
		sql.append("       NVL(A.REG_MON,0) REG_MON,  --开办资金														\n");
		sql.append("       DECODE(A.SORG_KIND,'1','法人','2','合伙','3','个体','') SORG_KIND,  --性质														\n");
		sql.append("       DECODE(NVL2(E.CHECK_TIME,1,0),'1','是','0','否','否') IF_NEW_BUILD,  --是否新成立							\n");
		sql.append("       DECODE(H.IF_BUILD_PARTY,'1','是','0','否','否') IF_BUILD_PARTY,  --是否建立党组织											\n");
		sql.append("       E.CHECK_TIME  --年检时间													\n");
		sql.append("  FROM SOM_ORGAN A																\n");
		sql.append("	/*查询分支机构数*/																\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(MAIN_SORG_CODE)  COUNT, MAIN_SORG_CODE			\n");
		sql.append("	               FROM SOM_ORGAN												\n");
		sql.append("	              WHERE SORG_TYPE = 'M'											\n");
		sql.append("	                AND SORG_STATUS = '22'										\n");
		sql.append("	              GROUP BY MAIN_SORG_CODE) B									\n");
		sql.append("	    ON B.MAIN_SORG_CODE = A.SORG_CODE										\n");
		sql.append("	/*民间组织负责人数*/															\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(SORG_ID)  DUTYCOUNT, SORG_ID						\n");
		sql.append("	               FROM SOM_DUTY												\n");
		sql.append("	              WHERE REG_STATUS = '1'										\n");
		sql.append("	                AND IF_SERVE = '1'											\n");
		sql.append("	              GROUP BY SORG_ID) C											\n");
		sql.append("	    ON C.SORG_ID = A.SORG_ID												\n");
		sql.append("	/*民间组织负责人数女*/															\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(SORG_ID)  DUTYFEMALECOUNT, SORG_ID				\n");
		sql.append("	               FROM SOM_DUTY, SOM_PEOPLE									\n");
		sql.append("	              WHERE REG_STATUS = '1'										\n");
		sql.append("	                AND IF_SERVE = '1'											\n");
		sql.append("	                AND SOM_PEOPLE.PEOPLE_ID = SOM_DUTY.PEOPLE_ID				\n");
		sql.append("	                AND SOM_PEOPLE.SEX = '2'									\n");
		sql.append("	              GROUP BY SORG_ID) D											\n");
		sql.append("	    ON D.SORG_ID = A.SORG_ID												\n");
		sql.append("	/*年检基本表*/																\n");
		sql.append("	  LEFT JOIN (SELECT SORG_CODE, SORG_TYPE, TASK_CODE, BORG_NAME, CHECK_TIME	\n");
		sql.append("	               FROM SOM_CHECK E1											\n");
		sql.append("	              WHERE BATCH_YEAR = (SELECT MAX(BATCH_YEAR)					\n");
		sql.append("	                                    FROM SOM_CHECK E2						\n");
		sql.append("	                                   WHERE E1.SORG_CODE = E2.SORG_CODE		\n");
		sql.append("	                                   GROUP BY SORG_CODE)) E					\n");
		sql.append("	    ON E.SORG_CODE = A.SORG_CODE											\n");
		sql.append("	   AND E.SORG_TYPE = A.SORG_TYPE											\n");				
		sql.append("     /*业务活动表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_BUSINESS_ACTIVITY F									\n");
		sql.append("	    ON F.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*业务主管单位表*/																\n");
		sql.append("	  LEFT JOIN SOM_BUSINESS_ORGAN G											\n");
		sql.append("	    ON G.BORG_CODE = A.BORG_NAME											\n");
		sql.append("	/*党建表*/																	\n");
		sql.append("	  LEFT JOIN SOM_CHECK_PARTY H												\n");
		sql.append("	    ON H.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*资产负债表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_BALANCE_SHEET I										\n");
		sql.append("	    ON I.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*公益支出情况表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_EXPENDITURE J											\n");
		sql.append("	    ON J.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*接受捐赠情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CONTRIBUTE K												\n");
		sql.append("	    ON K.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	   AND K.IF_OPEN = '0'														\n");
		sql.append("	/*公开募捐情况表*/																\n");
		sql.append("	  LEFT JOIN SOM_CONTRIBUTE L												\n");
		sql.append("	    ON L.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	   AND K.IF_OPEN = '1'														\n");
		sql.append("	/*公益活动情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_PUBLIC_BENEFIT M										\n");
		sql.append("	    ON M.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	 WHERE A.SORG_TYPE = 'M'													\n");
		sql.append("	   AND A.SORG_STATUS = '22'													\n");	
		sql.append("	   AND A.MORG_AREA LIKE ?													\n");		
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		}else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}

	/**
	 * 查询基金会台帐
	 */
	public DataSet queryFundAccount(ParameterSet pset) {
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		typeList.add(Types.VARCHAR);
		List<Object> objList = new ArrayList<Object>();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		objList.add(morgArea);
		sql.append("SELECT A.REG_DATE ,	--登记时间													\n");
		sql.append("       A.MORG_NAME , --登记部门													\n");
		sql.append("       A.SORG_CODE , --部门登记证号												\n");
		sql.append("       A.ORGAN_CODE , --组织机构代码												\n");
		sql.append("       '' t1,  --部门交换码															\n");
		sql.append("       A.CN_NAME,  --单位名称														\n");
		sql.append("       A.LEGAL_PEOPLE,  --法定代表人												\n");
		sql.append("       A.RESIDENCE,  --地址														\n");
		sql.append("       A.SORG_POST,  --邮编														\n");
		sql.append("       A.SORG_PHONE,  --电话														\n");
		sql.append("       A.BUS_SCOPE,  --行业分类代码												\n");
		sql.append("       '' t2,  --变动类型代码															\n");
		sql.append("       '' t3,  --变动时间															\n");
		sql.append("       '' t4,  --类型																\n");
		sql.append("       NVL(B.COUNT, 0)  BRANCH_COUNT, --分支机构									\n");
		sql.append("       NVL(C.DUTYCOUNT, 0)  DUTY_COUNT, --民间组织负责人数							\n");
		sql.append("       NVL(D.DUTYFEMALECOUNT, 0)  DUTY_FEMALE_COUNT, --民间组织负责人数女			\n");
		sql.append("       NVL(A.ENGAGED_NUM,0) ENGAGED_NUM, --年末从业人数												\n");
		sql.append("       '' t5,  --年末从业人数女														\n");
		sql.append("       NVL(H.PARTY_PRACTITIONER_NUM,0) PARTY_PRACTITIONER_NUM,  --年末从业人数党员								\n");
		sql.append("       '' t6,  --受教育程度大学专科													\n");
		sql.append("       '' t7,  --受教育程度大学本科及以上												\n");
		sql.append("       '' t8,  --职业资格水平助理社会工作师												\n");
		sql.append("       '' t9,  --职业资格水平社会工作师													\n");
		sql.append("       '' t10,  --年龄结构35岁及以下													\n");
		sql.append("       '' t11,  --年龄结构36岁至45岁													\n");
		sql.append("       '' t12,  --年龄结构46岁至55岁													\n");
		sql.append("       '' t13,  --年龄结构56岁及以上													\n");
		sql.append("       '' t14,  --执行会计制度															\n");
		sql.append("       NVL(I.FA_PRIME_COST_E,0) FA_PRIME_COST_E,  --固定资产原价											\n");
		sql.append("       NVL(I.FA_NET_VALUE_S,0) FA_NET_VALUE_S,  --上年结余												\n");
		sql.append("       NVL(I.FA_ACCUMULATED_DEPRECIATION_E - I.FA_ACCUMULATED_DEPRECIATION_S,0) FA_ACCUMULATED_DEPRECIATION,  --本年折旧		\n");
		sql.append("       NVL(F.INCOME_SUM_TY_SUM,0) INCOME_SUM_TY_SUM,  --营业收入											\n");
		sql.append("       NVL(F.COST_SUM_TY_SUM,0) COST_SUM_TY_SUM,  --营业成本												\n");
		sql.append("       NVL(F.TAXES_TY_SUM,0) TAXES_TY_SUM,  --营业税金及附加											\n");
		sql.append("       '' t15,  --销售费用															\n");
		sql.append("       NVL(F.MANAGE_COST_TY_SUM,0) MANAGE_COST_TY_SUM,  --管理费用											\n");
		sql.append("       '' t16,  --管理费用税金															\n");
		sql.append("       '' t17,  --管理费用差旅费														\n");
		sql.append("       '' t18,  --财务费用															\n");
		sql.append("       '' t19,  --财务费用利息支出														\n");											
		sql.append("       '' t20,  --公允价值变动收益														\n");
		sql.append("       NVL(F.INV_INCOME_TY_SUM,0) INV_INCOME_TY_SUM,  --投资收益											\n");
		sql.append("       '' t21,  --营业利润															\n");
		sql.append("       NVL(J.COMM_EXP_PER,0) COMM_EXP_PER,  --应付职工薪酬												\n");
		sql.append("       --本年度收入合计 INCOME_SUM_TY_SUM											\n");
		sql.append("       NVL(F.GOV_GRANTS_TY_SUM,0) GOV_GRANTS_TY_SUM,  --本年度收入合计事业收入								\n");
		sql.append("       '' t22,  --本年度收入合计经营收入													\n");
		sql.append("       NVL(F.DONATION_INCOME_TY_SUM,0) DONATION_INCOME_TY_SUM,  --本年度收入合计捐赠收入							\n");
		sql.append("       NVL(F.DUES_INCOME_TY_SUM,0) DUES_INCOME_TY_SUM,  --本年度收入合计会费收入								\n");
		sql.append("       --本年支出合计	COST_SUM_TY_SUM												\n");
		sql.append("       --本年支出合计工资福利支出 COMM_EXP_PER										\n");
		sql.append("       '' t23,  --本年支出合计商品和服务支出												\n");
		sql.append("       '' t24,  --商品和服务支出福利费													\n");
		sql.append("       '' t25,  --商品和服务支出劳务费													\n");
		sql.append("       '' t26,  --商品和服务支出取暖费													\n");
		sql.append("       '' t27,  --商品和服务支出差旅费													\n");
		sql.append("       '' t28,  --对个人和家庭补助支出													\n");
		sql.append("       '' t29,  --对个人和家庭补助支出助学金												\n");
		sql.append("       '' t30,  --对个人和家庭补助支出抚恤金												\n");
		sql.append("       '' t31,  --对个人和家庭补助支出生活补助											\n");
		sql.append("       NVL(F.ASSETS_CHANGE_TY_SUM,0) ASSETS_CHANGE_TY_SUM,  --收支结余										\n");
		sql.append("       NVL(I.CL_TAS_PAYABLE_E,0) CL_TAS_PAYABLE_E,  --经营税金											\n");
		sql.append("       --本年费用合计 COST_SUM_TY_SUM												\n");
		sql.append("       NVL(F.BUSINESS_COST_TY_SUM,0) BUSINESS_COST_TY_SUM,  --本年费用合计业务活动成本							\n");
		sql.append("       NVL(F.STAFF_COST_TY_SUM,0) STAFF_COST_TY_SUM,  --业务活动成本人员费用									\n");
		sql.append("       NVL(F.RUNNING_COST_TY_SUM,0) RUNNING_COST_TY_SUM,  --业务活动成本日常费用								\n");
		sql.append("       NVL(F.DEPRECIATION_ASSETS_TY_SUM,0) DEPRECIATION_ASSETS_TY_SUM,  --业务活动成本固定资产折旧						\n");
		sql.append("       --业务活动成本税费 TAXES_TY_SUM												\n");
		sql.append("       --本年费用合计管理费用 MANAGE_COST_TY_SUM									\n");
		sql.append("       '' t32,  --管理费用人员费用														\n");
		sql.append("       '' t33,  --管理费用日常费用														\n");
		sql.append("       '' t34,  --管理费用固定资产折旧													\n");
		sql.append("       '' t35,  --管理费用税费															\n");
		sql.append("       --净资产变动额 ASSETS_CHANGE_TY_SUM											\n");
		sql.append("       G.BORG_NAME,  --业务主管部门												\n");
		sql.append("       NVL(A.REG_MON,0) REG_MON,  --原始基金数额													\n");
		sql.append("       DECODE(H.IF_BUILD_PARTY,'1','是','0','否','否') IF_BUILD_PARTY,  --是否建立党组织											\n");
		sql.append("       NVL(L.CURRENT_MONEY,0) CURRENT_MONEY,  --本年度募集资金											\n");
		sql.append("       NVL(M.ACTIVITY_NUM,0) ACTIVITY_NUM,  --公益活动项目数											\n");
		sql.append("       E.CHECK_TIME,  --年检时间													\n");
		sql.append("       --本年捐赠现金收入 CURRENT_MONEY												\n");
		sql.append("       NVL(K.CURRENT_PRACTICALI,0) CURRENT_PRACTICALI  --本年捐赠实物折价									\n");
		sql.append("       --会费收入 DUES_INCOME_TY_SUM												\n");
		sql.append("  FROM SOM_ORGAN A																\n");
		sql.append("	/*查询分支机构数*/																\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(MAIN_SORG_CODE)  COUNT, MAIN_SORG_CODE			\n");
		sql.append("	               FROM SOM_ORGAN												\n");
		sql.append("	              WHERE SORG_TYPE = 'J'											\n");
		sql.append("	                AND SORG_STATUS = '22'										\n");
		sql.append("	              GROUP BY MAIN_SORG_CODE) B									\n");
		sql.append("	    ON B.MAIN_SORG_CODE = A.SORG_CODE										\n");
		sql.append("	/*民间组织负责人数*/															\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(SORG_ID)  DUTYCOUNT, SORG_ID						\n");
		sql.append("	               FROM SOM_DUTY												\n");
		sql.append("	              WHERE REG_STATUS = '1'										\n");
		sql.append("	                AND IF_SERVE = '1'											\n");
		sql.append("	              GROUP BY SORG_ID) C											\n");
		sql.append("	    ON C.SORG_ID = A.SORG_ID												\n");
		sql.append("	/*民间组织负责人数女*/															\n");
		sql.append("	  LEFT JOIN (SELECT COUNT(SORG_ID)  DUTYFEMALECOUNT, SORG_ID				\n");
		sql.append("	               FROM SOM_DUTY, SOM_PEOPLE									\n");
		sql.append("	              WHERE REG_STATUS = '1'										\n");
		sql.append("	                AND IF_SERVE = '1'											\n");
		sql.append("	                AND SOM_PEOPLE.PEOPLE_ID = SOM_DUTY.PEOPLE_ID				\n");
		sql.append("	                AND SOM_PEOPLE.SEX = '2'									\n");
		sql.append("	              GROUP BY SORG_ID) D											\n");
		sql.append("	    ON D.SORG_ID = A.SORG_ID												\n");
		sql.append("	/*年检基本表*/																\n");
		sql.append("	  LEFT JOIN (SELECT SORG_CODE, SORG_TYPE, TASK_CODE, BORG_NAME, CHECK_TIME	\n");
		sql.append("	               FROM SOM_CHECK E1											\n");
		sql.append("	              WHERE BATCH_YEAR = (SELECT MAX(BATCH_YEAR)					\n");
		sql.append("	                                    FROM SOM_CHECK E2						\n");
		sql.append("	                                   WHERE E1.SORG_CODE = E2.SORG_CODE		\n");
		sql.append("	                                   GROUP BY SORG_CODE)) E					\n");
		sql.append("	    ON E.SORG_CODE = A.SORG_CODE											\n");
		sql.append("	   AND E.SORG_TYPE = A.SORG_TYPE											\n");				
		sql.append("     /*业务活动表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_BUSINESS_ACTIVITY F									\n");
		sql.append("	    ON F.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*业务主管单位表*/																\n");
		sql.append("	  LEFT JOIN SOM_BUSINESS_ORGAN G											\n");
		sql.append("	    ON G.BORG_CODE = A.BORG_NAME											\n");
		sql.append("	/*党建表*/																	\n");
		sql.append("	  LEFT JOIN SOM_CHECK_PARTY H												\n");
		sql.append("	    ON H.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*资产负债表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_BALANCE_SHEET I										\n");
		sql.append("	    ON I.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*公益支出情况表*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_EXPENDITURE J											\n");
		sql.append("	    ON J.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	/*接受捐赠情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CONTRIBUTE K												\n");
		sql.append("	    ON K.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	   AND K.IF_OPEN = '0'														\n");
		sql.append("	/*公开募捐情况表*/																\n");
		sql.append("	  LEFT JOIN SOM_CONTRIBUTE L												\n");
		sql.append("	    ON L.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	   AND K.IF_OPEN = '1'														\n");
		sql.append("	/*公益活动情况*/																\n");
		sql.append("	  LEFT JOIN SOM_CHECK_PUBLIC_BENEFIT M										\n");
		sql.append("	    ON M.TASK_CODE = E.TASK_CODE											\n");
		sql.append("	 WHERE A.IF_BRANCH = '0'													\n");
		sql.append("	   AND A.SORG_TYPE = 'J'													\n");
		sql.append("	   AND A.SORG_STATUS = '22'													\n");	
		sql.append("	   AND A.MORG_AREA LIKE ?													\n");		
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		}else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}
	
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
}
