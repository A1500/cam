package com.inspur.sdmz.jzfa.dao.jdbc;

import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.sdmz.jtxx.dao.IYgjzJtxxDao;
import com.inspur.sdmz.jtxx.data.BaseinfoFamily;

/**
 * @title:YgjzJtxxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
 */
public class JtxxDao extends EntityDao<BaseinfoFamily> implements IYgjzJtxxDao {

	public JtxxDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return BaseinfoFamily.class;
	}

	// 更新成员数量
	public void updatePeopleNum(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("update baseinfo_family A \n");
		sql.append("set PEOPLE_NUM   = (select count(1) from baseinfo_people where A.FAMILY_ID = family_id), \n");
		sql.append("    YEAR_AVERAGE_INCOME = decode((select count(1) from baseinfo_people where A.family_id = family_id),0,0,round(YEAR_INCOME / (select count(1) from baseinfo_people where A.FAMILY_ID = family_id),2)) ,\n");
		sql.append("    MONTH_INCOME = round(YEAR_INCOME / 12,2) ,\n");
		sql.append("    MONTH_AVERAGE_INCOME = decode((select count(1)*12 from baseinfo_people where A.family_id = family_id),0,0,round(YEAR_INCOME / (select count(1)*12 from baseinfo_people where A.FAMILY_ID = family_id),2)) ,\n");
		sql.append("    BUILD_AVERAGE_AREA   = decode((select count(1) from baseinfo_people where A.family_id = family_id),0,0,round(BUILD_AREA / (select count(1) from baseinfo_people where A.FAMILY_ID = family_id),2)) \n");
		sql.append("where family_id = '").append(familyId).append("' ");
		executeUpdate(sql.toString());
	}
	// 更该流程环节
	public void updateCurrentActivity(String activity, String jtids,String createOrgan ) {
		StringBuffer sql = new StringBuffer();
		sql.append("update baseinfo_family A \n");
		sql.append("set cur_activity   = '").append(activity).append("' \n");
		sql.append(" , CHECK_ORG_AREA   = '").append(createOrgan).append("' \n");
		sql.append("where family_id in ('").append(jtids.replaceAll(",", "','")).append("') ");

		executeUpdate(sql.toString());
	}
	// 得到教育救助列表
	public List getNeedJyJzList(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select MAX(B.EDUCATION) EDUCATION, max(b.GRADE) GRADE \n");
		sql.append("  from baseinfo_people A, sam_people_edu B \n");
		sql.append(" where A.PEOPLE_ID = B.PEOPLE_ID                    \n");
		sql.append("   and A.family_id = '").append(familyId).append("'\n");
		sql.append("   and B.EDUCATION <> '7'                    \n");
		sql.append("   group by a.PEOPLE_ID,b.EDUCATION               \n");
		return executeQuery(sql.toString());
	}
	// 得到医疗救助列表
	public List getMedicalJzList(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select COST_MON    \n");
		sql.append("  from baseinfo_people A, SAM_PEOPLE_DISEASE B \n");
		sql.append(" where A.PEOPLE_ID = B.PEOPLE_ID                    \n");
		sql.append("   and A.family_id = '").append(familyId).append("'\n");
		return executeQuery(sql.toString());
	}
	// 得到残疾救助列表
	public List getDeformityJzList(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select DISABILITY_LEVEL \n");
		sql.append("  from baseinfo_people A, SAM_PEOPLE_DISABILITY B \n");
		sql.append(" where A.PEOPLE_ID = B.PEOPLE_ID                    \n");
		sql.append("   and A.family_id = '").append(familyId).append("'\n");
		return executeQuery(sql.toString());
	}
	// 得到事故救助列表
	public List getSgSsMoneyList(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select LOSS_MON   \n");
		sql.append("  from baseinfo_people A, SAM_PEOPLE_ACCIDENT B \n");
		sql.append(" where A.PEOPLE_ID = B.PEOPLE_ID                    \n");
		sql.append("   and A.family_id = '").append(familyId).append("'\n");
		return executeQuery(sql.toString());
	}
	// 得到已救助列表
	public List getAlreadyJzList(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select ASSISTED_SIDE,   \n");
		sql.append("   sum(case when add_months(to_date(ASSITANCE_DATE,'YYYY-MM-DD'),12) - sysdate > 0 then 0 else 1 end) ALREADY_TIMES, \n");
		sql.append("   sum(case when add_months(to_date(ASSITANCE_DATE,'YYYY-MM-DD'),12) - sysdate > 0 then nvl(TOTAL_FUND,0) else 0 end) money_inayear  \n");
		sql.append("  from SAM_PLAN_DETAIL \n");
		sql.append(" where ASSISTED_ID = '").append(familyId).append("'\n");
		sql.append("  group by ASSISTED_SIDE  ");
		return executeQuery(sql.toString());
	}
	// 更新计算状态
	/*public void updateJtdz(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("update baseinfo_family A \n");
		sql.append("set JTDZ   = '1' \n");
		sql.append("where family_id = '").append(familyId).append("' ");
		executeUpdate(sql.toString());
	}*/
}
