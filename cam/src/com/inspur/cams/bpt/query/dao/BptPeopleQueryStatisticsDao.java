package com.inspur.cams.bpt.query.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.comm.util.DateUtil;

public class BptPeopleQueryStatisticsDao extends BaseJdbcDao {

	public BptPeopleQueryStatisticsDao() {
		super();
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
	}

	@Override
	protected void initDao() {
	}

	public DataSet queryDisability(ParameterSet set) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select baseinfo.name name ,baseinfo.sex sex ,baseinfo.idcard idcard , baseinfo.birthday birthday,baseinfo.domiciletype domiciletype,");
		sql.append("baseinfo.domicilecode domicilecode,baseinfo.workunit workunit,baseinfo.workdate workdate,baseinfo.retired_date retired_date,");
		sql.append("baseinfo.address address,baseinfo.disabilitytype disabilitytype,baseinfo.disabilitygenus disabilitygenus,baseinfo.disabilitycase disabilitycase, ");
		sql.append("baseinfo.disabilitylevel disabilitylevel,baseinfo.disabilitydate disabilitydate,baseinfo.disabilityno disabilityno, baseinfo.peopleid peopleid, amount.moun moun ,'' note ");
		sql.append(" from (select info.name name,info.sex sex, info.id_card idCard, info.birthday birthday, info.domicile_type domicileType, ");
		sql.append("disability.retired_date retired_date, (select city.name from dic_city city ");
		sql.append(" where city.id = info.apanage_code)  address, info.domicile_code domicileCode, info.disability_no disabilityNo,");
		sql.append("info.work_unit_name workUnit,people.disability_type_code disabilityType,disability.disability_level_code disabilityLevel, ");
		sql.append("disability.disability_war_code disabilityDate, disability.disability_genus_code disabilityGenus,disability.disability_case_code  disabilityCase,");
		sql.append(" disability.to_work_date workDate, info.people_id peopleId ");
		sql.append(" from baseinfo_people  info,bpt_people  people, bpt_people_disability disability  ");
		sql.append(" where people.people_id = info.people_id and disability.people_id = info.people_id  and info.disability_flag = '1'");
		/* 添加查询条件 */
		String name = (String) set.getParameter("name");// 姓名
		if (name != null && !name.equals("")) {
			sql.append(" and info.name like '%'||?||'%'  ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		String idCard = (String) set.getParameter("idCard");// 身份证号
		if (idCard != null && !idCard.equals("")) {
			sql.append(" and info.id_card = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		/*String pinyin = (String) set.getParameter("pinyin");// 拼音码
		if (pinyin != null && !pinyin.equals("")) {
			sql.append(" and info.phonetic_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(pinyin);
		}*/
		String domicile_type = (String) set.getParameter("domicileType");// 户籍类型
		if (domicile_type != null && !domicile_type.equals("")) {
			sql.append(" and info.domicile_type =? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicile_type);
		}
		String xzqu = (String) set.getParameter("xzqu");// 所属机构
		if (xzqu != null && !xzqu.equals("")) {
			if (!xzqu.substring(0, 2).equals("00")
					&& xzqu.substring(2, 4).equals("00")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 2), 12, 0)=?");// 省局
			} else if (!xzqu.substring(2, 4).equals("00")
					&& xzqu.substring(4).equals("00000000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 4), 12, 0)=?");// 市局
			} else if (!xzqu.substring(4, 6).equals("00")
					&& xzqu.substring(7, 10).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 6), 12, 0)=?");// 区县
			} else if (!xzqu.substring(7, 10).equals("000")
					&& xzqu.substring(9, 12).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 9), 12, 0)=?");// 街道
			} else {
				sql.append(" and info.domicile_code=?");// 社区
			}
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}
		String zsNo = (String) set.getParameter("zsNo");// 证件编号
		if (zsNo != null && !zsNo.equals("")) {
			sql.append(" and info.disability_no = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(zsNo);
		}
		String state = (String) set.getParameter("disabilityStateCode");// 状态
		if (state != null && !state.equals("")) {
			sql.append(" and info.DISABILITY_STATE_CODE =? ");
			typeList.add(Types.VARCHAR);
			argsList.add(state);
		}
		String disabilityTypeCode = (String) set
				.getParameter("disabilityTypeCode"); // 伤残类型
		if (disabilityTypeCode != null && !disabilityTypeCode.equals("")) {
			sql.append(" and people.disability_type_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityTypeCode);
		}
		String disabilityLevelCode = (String) set.getParameter("disabilityLevelCode");// 伤残级别
		if (disabilityLevelCode != null && !disabilityLevelCode.equals("")) {
			sql.append("  and disability.disability_level_code in ( " + disabilityLevelCode + " ) ");
		}
		String disabilityCaseCode = (String) set.getParameter("disabilityCaseCode");// 伤残性质
		if (disabilityCaseCode != null && !disabilityCaseCode.equals("")) {
			sql.append("  and disability.disability_case_code  =? ");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityCaseCode);
		}

		String disabilityGenusCode = (String) set
				.getParameter("disabilityGenusCode");// 伤残属别
		if (disabilityGenusCode != null && !disabilityGenusCode.equals("")) {
			sql.append("  and disability.disability_genus_code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityGenusCode);
		}

		String disabilityWarCode = (String) set
				.getParameter("disabilityWarCode");// 伤残时期
		if (disabilityWarCode != null && !disabilityWarCode.equals("")) {
			sql.append("  and disability.disability_war_code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityWarCode);
		}
		sql.append("  ) baseinfo right join (select sum(detail.grant_mon_sum) moun, ");
		sql.append(" detail.people_id peopleId  from bpt_capital_detail detail ,bpt_capital_summary summary  ");
		sql.append(" where detail.register_id = summary.register_id  and detail.register_type = '11' ");

		String cxsj_q = (String) set.getParameter("cxsj_q");// 起止时间
		String cxsj_z = (String) set.getParameter("cxsj_z");
		if (cxsj_q != null && cxsj_z != null) {
			sql.append(" and to_date(summary.grant_date,'yyyy-mm-dd')  ");
			sql.append(" between to_date( ? ,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			sql.append(" and to_date(? ,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();

		sql.append(" group by detail.people_id) amount on baseinfo.peopleid = amount.peopleId");
		sql.append(" where baseinfo.name is not null ");
		if (set.containsKey("limit"))
			return this.executeDataset(sql.toString(), types, args, set.getPageStart(), set.getPageLimit(), true);
		else
			// 用于导出Excel
			return this.executeDataset(sql.toString(), types, args, true);
	}

	public DataSet queryDemobilized(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select baseinfo.name, baseinfo.sex,baseinfo.idcard, baseinfo.birthday,baseinfo.domiciletype,");
		sql.append("  baseinfo.address,baseinfo.demobilizedno,baseinfo.workunit,baseinfo.safeguard,");
		sql.append(" baseinfo.medical, baseinfo.retiredtime,baseinfo.inlisttime,baseinfo.belongdate, amount.moun ,'' note  ");
		sql.append("  from (select info.name name, info.sex sex,  info.id_card idCard,info.birthday birthday,");
		sql.append("  info.domicile_type   domiciletype, (select city.name from dic_city city  where city.id = info.apanage_code) || ");
		sql.append(" info.address address,info.demobilized_no demobilizedno,  ");
		sql.append("  info.work_unit_name workUnit, info.safeguard_type safeguard , info.medical_code  medical,");
		sql.append(" demobilized.belongdate  belongdate,demobilized.conscript_date inlisttime ");
		sql.append(" , demobilized.decruitment_date retiredTime,info.people_id peopleId  ");
		sql.append(" from baseinfo_people info, bpt_people_demobilized demobilized  ");
		sql.append(" where demobilized.people_id = info.people_id  and info.demobilized_flag = 1 ");
		/* 添加查询条件 */
		String xzqu = (String) pset.getParameter("xzqu");// 所属机构
		if (xzqu != null && !xzqu.equals("")) {
			if (!xzqu.substring(0, 2).equals("00")
					&& xzqu.substring(2, 4).equals("00")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 2), 12, 0)=?");// 省局
			} else if (!xzqu.substring(2, 4).equals("00")
					&& xzqu.substring(4).equals("00000000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 4), 12, 0)=?");// 市局
			} else if (!xzqu.substring(4, 6).equals("00")
					&& xzqu.substring(7, 10).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 6), 12, 0)=?");// 区县
			} else if (!xzqu.substring(7, 10).equals("000")
					&& xzqu.substring(9, 12).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 9), 12, 0)=?");// 街道
			} else {
				sql.append(" and info.domicile_code=?");// 社区
			}
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}

		String name = (String) pset.getParameter("name");// 姓名
		if (name != null && !name.equals("")) {
			sql.append(" and info.name like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		/*String pinyin = (String) pset.getParameter("pinyin");// 拼音码
		if (pinyin != null && !pinyin.equals("")) {
			sql.append(" and info.phonetic_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(pinyin);
		}*/

		String demobilizedno = (String) pset.getParameter("demobilizedno");// 证件编码
		if (demobilizedno != null && !demobilizedno.equals("")) {
			sql.append(" and info.demobilized_no = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(demobilizedno);
		}

		String idcard = (String) pset.getParameter("idCard");// 身份证号
		if (idcard != null && !idcard.equals("")) {
			sql.append(" and info.id_card = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idcard);
		}

		String domiciletype = (String) pset.getParameter("domicileType");// 户籍类型
		if (domiciletype != null && !domiciletype.equals("")) {
			sql.append(" and info.domicile_type = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domiciletype);
		}

		String state = (String) pset.getParameter("demobilizedState");// 优抚状态
		if (state != null && !state.equals("")) {
			sql.append(" and info.demobilized_state_code =? ");
			typeList.add(Types.VARCHAR);
			argsList.add(state);
		}
		sql.append("  ) baseinfo  right join (select sum(detail.grant_mon_sum) moun,  detail.people_id peopleId ");
		sql.append(" from bpt_capital_detail detail ,bpt_capital_summary summary  ");
		sql.append("  where detail.register_id = summary.register_id  and detail.register_type = '41' ");
		String cxsj_q = (String) pset.getParameter("cxsj_q");// 起止时间
		String cxsj_z = (String) pset.getParameter("cxsj_z");
		if (cxsj_q != null && cxsj_z != null) {
			sql.append(" and to_date(summary.grant_date,'yyyy-mm-dd')  ");
			sql.append(" between to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			sql.append(" and to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object args[] = argsList.toArray();
		sql.append(" group by detail.people_id ) amount  on amount.peopleId = baseinfo.peopleId ");
		sql.append(" where baseinfo.name is not null  ");
		if (pset.containsKey("limit")) {
			return this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {// 用于打印
			return this.executeDataset(sql.toString(), types, args, true);
		}
	}

	public DataSet queryDemobilizedIllness(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select baseinfo.name, baseinfo.sex,baseinfo.idcard, baseinfo.birthday,baseinfo.domiciletype,");
		sql.append("  baseinfo.address,baseinfo.demobilizedno,baseinfo.workunit,baseinfo.safeguard,baseinfo.medical,");
		sql.append("  baseinfo.retiredtime,baseinfo.inlisttime, baseinfo.war,baseinfo.innuclear, amount.moun ,'' note ");
		sql.append("  from (select info.name name, info.sex sex,  info.id_card idCard,info.birthday birthday,");
		sql.append("  info.domicile_type   domiciletype, (select city.name from dic_city city  where city.id = info.apanage_code) || ");
		sql.append(" info.address address,info.demobilized_no demobilizedno,  ");
		sql.append("  info.work_unit_name workUnit, info.safeguard_type safeguard , info.medical_code  medical,");
		sql.append(" demobilized.is_war war , demobilized.is_innuclear innuclear ,demobilized.conscript_date inlisttime ");
		sql.append(" , demobilized.decruitment_date retiredTime,info.people_id peopleId  ");
		sql.append(" from baseinfo_people info, bpt_people_demobilized_illness demobilized  ");
		sql.append(" where demobilized.people_id = info.people_id and info.demobilized_flag = 1 ");
		/* 添加查询条件 */
		String xzqu = (String) pset.getParameter("xzqu");// 所属机构
		if (xzqu != null && !xzqu.equals("")) {
			if (!xzqu.substring(0, 2).equals("00")
					&& xzqu.substring(2, 4).equals("00")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 2), 12, 0)=?");// 省局
			} else if (!xzqu.substring(2, 4).equals("00")
					&& xzqu.substring(4).equals("00000000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 4), 12, 0)=?");// 市局
			} else if (!xzqu.substring(4, 6).equals("00")
					&& xzqu.substring(7, 10).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 6), 12, 0)=?");// 区县
			} else if (!xzqu.substring(7, 10).equals("000")
					&& xzqu.substring(9, 12).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 9), 12, 0)=?");// 街道
			} else {
				sql.append(" and info.domicile_code=?");// 社区
			}
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}

		String name = (String) pset.getParameter("name");// 姓名
		if (name != null && !name.equals("")) {
			sql.append(" and info.name like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		/*String pinyin = (String) pset.getParameter("pinyin");// 拼音码
		if (pinyin != null && !pinyin.equals("")) {
			sql.append(" and info.phonetic_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(pinyin);
		}*/

		String demobilizedno = (String) pset.getParameter("demobilizedno");// 证件编码
		if (demobilizedno != null && !demobilizedno.equals("")) {
			sql.append(" and info.demobilized_no = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(demobilizedno);
		}

		String idcard = (String) pset.getParameter("idCard");// 身份证号
		if (idcard != null && !idcard.equals("")) {
			sql.append(" and info.id_card like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(idcard);
		}

		String domiciletype = (String) pset.getParameter("domicileType");// 户籍类型
		if (domiciletype != null && !domiciletype.equals("")) {
			sql.append(" and info.domicile_type =? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domiciletype);
		}

		String state = (String) pset.getParameter("demobilizedState");// 优抚状态
		if (state != null && !state.equals("")) {
			sql.append(" and info.demobilized_state_code =? ");
			typeList.add(Types.VARCHAR);
			argsList.add(state);
		}

		sql.append("  ) baseinfo  right join (select sum(detail.grant_mon_sum) moun,  detail.people_id peopleId ");
		sql.append(" from bpt_capital_detail detail ,bpt_capital_summary summary  ");
		sql.append("  where detail.register_id = summary.register_id  and detail.register_type = '42' ");
		String cxsj_q = (String) pset.getParameter("cxsj_q");// 起止时间
		String cxsj_z = (String) pset.getParameter("cxsj_z");
		if (cxsj_q != null && cxsj_z != null) {
			sql.append(" and to_date(summary.grant_date,'yyyy-mm-dd')  ");
			sql.append(" between to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			sql.append(" and to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		sql.append(" group by detail.people_id ) amount  on amount.peopleId = baseinfo.peopleId ");
		sql.append(" where baseinfo.name is not null  ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		if (pset.containsKey("limit")) {
			return this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {// 用于打印
			return this.executeDataset(sql.toString(), types, args, true);
		}
	}

	public DataSet queryDependent(ParameterSet pset) {

		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select baseinfo.name, baseinfo.sex,baseinfo.idcard, baseinfo.birthday,baseinfo.domiciletype,baseinfo.dependantType,");
		sql.append("  baseinfo.address,baseinfo.demobilizedno,baseinfo.workunit,baseinfo.safeguard,baseinfo.medical,  amount.moun, '' note ");
		sql.append("  from (select info.name name, info.sex sex,  info.id_card idCard,info.birthday birthday,");
		sql.append("  info.domicile_type   domiciletype,(select city.name from dic_city city ");
		sql.append(" where city.id = info.apanage_code)  address,info.DEPENDANT_NO demobilizedno,");
		sql.append("  info.work_unit_name workUnit, info.safeguard_type safeguard , info.medical_code  medical,");
		sql.append(" people.dependant_type_code dependantType,info.people_id peopleId  ");
		sql.append(" from baseinfo_people info, bpt_people  people ");
		sql.append(" where people.people_id = info.people_id and info.DEPENDANT_FLAG = 1 ");
		/* 添加查询条件 */
		String xzqu = (String) pset.getParameter("xzqu");// 所属机构
		if (xzqu != null && !xzqu.equals("")) {
			if (!xzqu.substring(0, 2).equals("00")
					&& xzqu.substring(2, 4).equals("00")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 2), 12, 0)=?");// 省局
			} else if (!xzqu.substring(2, 4).equals("00")
					&& xzqu.substring(4).equals("00000000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 4), 12, 0)=?");// 市局
			} else if (!xzqu.substring(4, 6).equals("00")
					&& xzqu.substring(7, 10).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 6), 12, 0)=?");// 区县
			} else if (!xzqu.substring(7, 10).equals("000")
					&& xzqu.substring(9, 12).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 9), 12, 0)=?");// 街道
			} else {
				sql.append(" and info.domicile_code=?");// 社区
			}
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}

		String name = (String) pset.getParameter("name");// 姓名
		if (name != null && !name.equals("")) {
			sql.append(" and info.name like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		/*String pinyin = (String) pset.getParameter("pinyin");// 拼音码
		if (pinyin != null && !pinyin.equals("")) {
			sql.append(" and info.phonetic_code like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(pinyin);
		}*/

		String demobilizedno = (String) pset.getParameter("demobilizedno");// 证件编码
		if (demobilizedno != null && !demobilizedno.equals("")) {
			sql.append(" and info.DEPENDANT_NO like '%'||?||'%'  ");
			typeList.add(Types.VARCHAR);
			argsList.add(demobilizedno);
		}

		String idcard = (String) pset.getParameter("idCard");// 身份证号
		if (idcard != null && !idcard.equals("")) {
			sql.append(" and info.id_card like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(idcard);
		}

		String domiciletype = (String) pset.getParameter("domicileType");// 户籍类型
		if (domiciletype != null && !domiciletype.equals("")) {
			sql.append(" and info.domicile_type = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(domiciletype);
		}

		String state = (String) pset.getParameter("demobilizedState");// 优抚状态
		if (state != null && !state.equals("")) {
			sql.append(" and info.DEPENDANT_STATE_CODE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(state);
		}

		sql.append("  ) baseinfo  right join (select sum(detail.grant_mon_sum) moun,  detail.people_id peopleId ");
		sql.append(" from bpt_capital_detail detail ,bpt_capital_summary summary  ");
		sql.append("  where detail.register_id = summary.register_id  and detail.register_type = '21' ");
		String cxsj_q = (String) pset.getParameter("cxsj_q");// 起止时间
		String cxsj_z = (String) pset.getParameter("cxsj_z");
		if (cxsj_q != null && cxsj_z != null) {
			sql.append(" and to_date(summary.grant_date,'yyyy-mm-dd')  ");
			sql.append(" between to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			sql.append(" and to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		sql.append(" group by detail.people_id ) amount  on amount.peopleId = baseinfo.peopleId ");
		sql.append(" where baseinfo.name is not null  ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		if (pset.containsKey("limit")) {
			return this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {// 用于打印
			return this.executeDataset(sql.toString(), types, args, true);
		}
	}

	public DataSet queryWarTested(ParameterSet pset) {

		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String serviceType = (String) pset.getParameter("serviceType");

		sql.append("select baseinfo.name, baseinfo.sex,baseinfo.idcard, baseinfo.birthday,baseinfo.domiciletype,");
		sql.append("  baseinfo.address,baseinfo.demobilizedno,baseinfo.workunit,baseinfo.safeguard,baseinfo.medical");
		sql.append(" ,baseinfo.warType,baseinfo.warcode,baseinfo.testcode,  amount.moun ,'' note ");
		sql.append("  from (select info.name name, info.sex sex,  info.id_card idCard,info.birthday birthday,");
		sql.append("  info.domicile_type   domiciletype, (select city.name from dic_city city where city.id = info.apanage_code)");
		sql.append("   address,info.war_no demobilizedno, ");
		sql.append("  info.work_unit_name workUnit, info.safeguard_type safeguard , info.medical_code  medical,");
		sql.append(" people.war_type_code warType, war.war_type_code warcode, '' testcode,info.people_id peopleId  ");
		sql.append(" from baseinfo_people info, bpt_people people, bpt_people_war war ");
		sql.append(" where people.people_id = info.people_id  and war.people_id = info.people_id and info.war_flag = 1 ");
		/* 添加查询条件 */
		String xzqu = (String) pset.getParameter("xzqu");// 所属机构
		if (xzqu != null && !xzqu.equals("")) {
			if (!xzqu.substring(0, 2).equals("00")
					&& xzqu.substring(2, 4).equals("00")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 2), 12, 0)=?");// 省局
			} else if (!xzqu.substring(2, 4).equals("00")
					&& xzqu.substring(4).equals("00000000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 4), 12, 0)=?");// 市局
			} else if (!xzqu.substring(4, 6).equals("00")
					&& xzqu.substring(7, 10).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 6), 12, 0)=?");// 区县
			} else if (!xzqu.substring(7, 10).equals("000")
					&& xzqu.substring(9, 12).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 9), 12, 0)=?");// 街道
			} else {
				sql.append(" and info.domicile_code=?");// 社区
			}
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}

		String name = (String) pset.getParameter("name");// 姓名
		if (name != null && !name.equals("")) {
			sql.append(" and info.name like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		/*String pinyin = (String) pset.getParameter("pinyin");// 拼音码
		if (pinyin != null && !pinyin.equals("")) {
			sql.append(" and info.phonetic_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(pinyin);
		}*/
		String demobilizedno = (String) pset.getParameter("demobilizedno");// 证件编码
		if (demobilizedno != null && !demobilizedno.equals("")) {
			sql.append(" and info.demobilized_no = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(demobilizedno);
		}
		String idcard = (String) pset.getParameter("idCard");// 身份证号
		if (idcard != null && !idcard.equals("")) {
			sql.append(" and info.id_card = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idcard);
		}
		String domiciletype = (String) pset.getParameter("domicileType");// 户籍类型
		if (domiciletype != null && !domiciletype.equals("")) {
			sql.append(" and info.domicile_type = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domiciletype);
		}
		String state = (String) pset.getParameter("demobilizedState");// 优抚状态
		if (state != null && !state.equals("")) {
			sql.append(" and info.war_state_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(state);
		}
		if (serviceType != null && !"".equals(serviceType)) {
			sql.append(" and people.war_type_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		sql.append(" union all ");
		sql.append("  select info.name name, info.sex sex,  info.id_card idCard,info.birthday birthday,");
		sql.append("  info.domicile_type   domiciletype,info.address address,info.war_no demobilizedno,");
		sql.append("  info.work_unit_name workUnit, info.safeguard_type safeguard , info.medical_code  medical,");
		sql.append(" people.war_type_code warType, '' warcode, test.tested_type testcode,info.people_id peopleId  ");
		sql.append(" from baseinfo_people info, bpt_people people, bpt_people_tested test ");
		sql.append(" where people.people_id = info.people_id  and test.people_id = info.people_id and info.war_flag = 1 ");
		/* 添加查询条件 */
		if (xzqu != null && !xzqu.equals("")) {
			if (!xzqu.substring(0, 2).equals("00")
					&& xzqu.substring(2, 4).equals("00")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 2), 12, 0)=?");// 省局
			} else if (!xzqu.substring(2, 4).equals("00")
					&& xzqu.substring(4).equals("00000000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 4), 12, 0)=?");// 市局
			} else if (!xzqu.substring(4, 6).equals("00")
					&& xzqu.substring(7, 10).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 6), 12, 0)=?");// 区县
			} else if (!xzqu.substring(7, 10).equals("000")
					&& xzqu.substring(9, 12).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 9), 12, 0)=?");// 街道
			} else {
				sql.append(" and info.domicile_code=?");// 社区
			}
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}

		if (name != null && !name.equals("")) {
			sql.append(" and info.name like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		/*if (pinyin != null && !pinyin.equals("")) {
			sql.append(" and info.phonetic_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(pinyin);
		}*/
		if (demobilizedno != null && !demobilizedno.equals("")) {
			sql.append(" and info.demobilized_no = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(demobilizedno);
		}
		if (idcard != null && !idcard.equals("")) {
			sql.append(" and info.id_card = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idcard);
		}
		if (domiciletype != null && !domiciletype.equals("")) {
			sql.append(" and info.domicile_type = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(domiciletype);
		}
		if (state != null && !state.equals("")) {
			sql.append(" and info.war_state_code =?");
			typeList.add(Types.VARCHAR);
			argsList.add(state);
		}
		if (serviceType != null && !"".equals(serviceType)) {
			sql.append(" and people.war_type_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		sql.append("  ) baseinfo  right join (select sum(detail.grant_mon_sum) moun,  detail.people_id peopleId ");
		sql.append(" from bpt_capital_detail detail ,bpt_capital_summary summary  ");
		sql.append("  where  detail.register_type = '51' ");
		String cxsj_q = (String) pset.getParameter("cxsj_q");// 起止时间
		String cxsj_z = (String) pset.getParameter("cxsj_z");
		if (cxsj_q != null && cxsj_z != null) {
			sql.append(" and to_date(summary.grant_date,'yyyy-mm-dd')  ");
			sql.append(" between to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			sql.append(" and to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		sql.append(" group by detail.people_id ) amount  on amount.peopleId = baseinfo.peopleId ");
		sql.append(" where baseinfo.name is not null  ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		if (pset.containsKey("limit")) {
			return this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {// 用于打印
			return this.executeDataset(sql.toString(), types, args, true);
		}
	}

	/**
	 * 查询优待金详细人员信息
	 * 
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryCompulsory(ParameterSet pset) {

		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.NAME, B.ID_CARD, B.SEX, B.NATION, B.BIRTHDAY,\n");
		sql.append("       B.DOMICILE_TYPE, B.ADDRESS, B.WORK_UNIT_NAME,\n"); 
		sql.append("       DECODE(SUBSTR(T.OBJECT_TYPE_CODE, 1, 1),\n"); 
		sql.append("               '1',\n"); 
		sql.append("               B.DISABILITY_NO,\n"); 
		sql.append("               '2',\n"); 
		sql.append("               B.DEPENDANT_NO,\n"); 
		sql.append("               '4',\n"); 
		sql.append("               B.DEMOBILIZED_NO,\n"); 
		sql.append("               NULL) BPT_NO, T.OBJECT_TYPE_CODE, T.MON_SUM, C.FULL_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, DIC_CITY C,\n"); 
		sql.append("       (SELECT SUM(D.GRANT_MON_SUM) MON_SUM, D.PEOPLE_ID, D.OBJECT_TYPE_CODE\n"); 
		sql.append("           FROM BPT_COMPULSORY_DETAILS D, BPT_COMPULSORY_SUMMARY S\n"); 
		sql.append(" WHERE D.REGISTER_ID = S.REGISTER_ID");
		String objectType = (String) pset.getParameter("objectType");
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String domicileType = (String) pset.getParameter("domicileType");
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" and to_date(s.grant_date, 'yyyy-mm-dd') between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		sql.append("  group by d.people_id,d.object_type_code) t  where b.domicile_code = c.id  and b.people_id = t.people_id");

		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" and substr(b.domicile_code,1,2) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2));
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" and substr(b.domicile_code,1,4) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" and substr(b.domicile_code,1,6) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6));
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" and substr(b.domicile_code,1,9) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9));
		} else { // 村
			sql.append(" and b.domicile_code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if (domicileType != null && !"".equals(domicileType)) {
			sql.append(" and b.domicile_type = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType);
		}
		if (objectType != null && !"0".equals(objectType)
				&& !"".equals(objectType)) {
			sql.append(" and  t.object_type_code like ?");
			typeList.add(Types.VARCHAR);
			if (objectType.length() == 1) {
				argsList.add(objectType + "_");
			} else {
				argsList.add(objectType);
			}
		} else {
			sql.append(" and  t.object_type_code is not null");
		}
		if (name != null && !"".equals(name)) {
			sql.append(" and  b.name like '%'|| ? || '%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if (idCard != null && !"".equals(idCard)) {
			sql.append(" and  b.id_card = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		sql.append(" ORDER BY b.DOMICILE_CODE,b.NAME");
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if (pset.containsKey("limit")) {

				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {// 用于Excel导出
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
		} else {
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(),
						pset.getPageLimit(), true);

			} else {// 用于Excel导出
				ds = this.executeDataset(sql.toString(), true);
			}
		}
		return ds;
	}

	/**
	 * 查询临时救助详细信息
	 * 
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryTemporaryHelp(ParameterSet pset) {
		DataSet ds = new DataSet();
		String objectType = (String) pset.getParameter("objectType");
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String domicileType = (String) pset.getParameter("domicileType");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.NAME, B.ID_CARD, B.SEX, B.NATION, B.BIRTHDAY,\n");
		sql.append("       B.DOMICILE_TYPE, B.ADDRESS, B.WORK_UNIT_NAME,\n"); 
		sql.append("       DECODE(SUBSTR(TH.OBJECT_TYPE, 1, 1),\n"); 
		sql.append("               '1',\n"); 
		sql.append("               B.DISABILITY_NO,\n"); 
		sql.append("               '2',\n"); 
		sql.append("               B.DEPENDANT_NO,\n"); 
		sql.append("               '4',\n"); 
		sql.append("               B.DEMOBILIZED_NO,\n"); 
		sql.append("               '5',\n"); 
		sql.append("               B.WAR_NO,\n"); 
		sql.append("               '6',\n"); 
		sql.append("               B.WAR_NO,\n"); 
		sql.append("               NULL) BPT_NO, TH.OBJECT_TYPE, TH.MON_SUM, C.FULL_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, DIC_CITY C,\n"); 
		sql.append("       (SELECT SUM(T.APPLY_MON) MON_SUM, T.PEOPLE_ID, T.OBJECT_TYPE\n"); 
		sql.append("           FROM BPT_TEMPORARY_HELP T");
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" where to_date(t.verify_date, 'yyyy-mm-dd') between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd') group by t.people_id, t.object_type");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		sql.append(" ) th  where b.domicile_code = c.id and b.people_id = th.people_id");
		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" and substr(b.domicile_code,1,2) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2));
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" and substr(b.domicile_code,1,4) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" and substr(b.domicile_code,1,6) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6));
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" and substr(b.domicile_code,1,9) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9));
		} else { // 村
			sql.append(" and b.domicile_code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if (domicileType != null && !"".equals(domicileType)) {
			sql.append(" and b.domicile_type = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType);
		}
		if (objectType != null && !"0".equals(objectType)
				&& !"".equals(objectType)) {
			sql.append(" and  th.object_type like ?");
			typeList.add(Types.VARCHAR);
			if (objectType.length() == 1) {
				argsList.add(objectType + "_");
			} else {
				argsList.add(objectType);
			}
		}
		if (name != null && !"".equals(name)) {
			sql.append(" and  b.name like '%'|| ? || '%'");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if (idCard != null && !"".equals(idCard)) {
			sql.append(" and  b.id_card = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		sql.append(" ORDER BY b.DOMICILE_CODE,b.NAME");
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
		} else {
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(),
						pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}
		}
		return ds;
	}

	@SuppressWarnings("unchecked")
	public DataSet queryCapitalPension(ParameterSet pset) {
		DataSet ds = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.NAME, B.ID_CARD, B.SEX, B.NATION, B.BIRTHDAY,\n");
		sql.append("       B.DOMICILE_TYPE, B.ADDRESS, B.WORK_UNIT_NAME,\n"); 
		sql.append("       DECODE(SUBSTR(T.OBJECT_TYPE, 1, 1), '1', B.DISABILITY_NO, '2', NULL) BPT_NO,\n"); 
		sql.append("       T.OBJECT_TYPE, T.MON_SUM, C.FULL_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, DIC_CITY C,\n"); 
		sql.append("       (SELECT SUM(D.GRANT_MON_SUM) MON_SUM, D.PEOPLE_ID, D.OBJECT_TYPE\n"); 
		sql.append("           FROM BPT_CAPITAL_DETAIL D, BPT_CAPITAL_SUMMARY S\n"); 
		sql.append(" WHERE D.REGISTER_ID = S.REGISTER_ID");
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" and to_date(s.grant_date, 'yyyy-mm-dd') between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')");
			sql.append(" and (d.register_type = '11' or d.register_type = '21') group by d.people_id, d.object_type) t ");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		sql.append(" where b.domicile_code = c.id  and b.people_id = t.people_id");
		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" and substr(b.domicile_code,1,2) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2));
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" and substr(b.domicile_code,1,4) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" and substr(b.domicile_code,1,6) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6));
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" and substr(b.domicile_code,1,9) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9));
		} else { // 村
			sql.append(" and b.domicile_code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if (name != null && !"".equals(name)) {
			sql.append(" and  b.name like ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name + "%");
		}
		if (idCard != null && !"".equals(idCard)) {
			sql.append(" and  b.id_card = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		sql.append(" ORDER BY b.DOMICILE_CODE, b.NAME ");
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
		} else {
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(),
						pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}
		}
		return ds;
	}

	/**
	 * 查询生活补助金人员统计情况
	 * 
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryGrant(ParameterSet pset) {
		DataSet ds = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.NAME, B.ID_CARD, B.SEX, B.NATION, B.BIRTHDAY,\n");
		sql.append("       B.DOMICILE_TYPE, B.ADDRESS, B.WORK_UNIT_NAME,\n"); 
		sql.append("       DECODE(SUBSTR(T.OBJECT_TYPE, 1, 1), '1', B.DISABILITY_NO, '2', NULL) BPT_NO,\n"); 
		sql.append("       T.OBJECT_TYPE, T.MON_SUM, C.FULL_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, DIC_CITY C,\n"); 
		sql.append("       (SELECT SUM(D.GRANT_MON_SUM) MON_SUM, D.PEOPLE_ID, D.OBJECT_TYPE\n"); 
		sql.append("           FROM BPT_CAPITAL_DETAIL D, BPT_CAPITAL_SUMMARY S\n"); 
		sql.append(" WHERE D.REGISTER_ID = S.REGISTER_ID");
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" and to_date(s.grant_date, 'yyyy-mm-dd') between");
			sql.append(" to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')");
			sql.append(" and (d.register_type= '41' or d.register_type = '42' or d.register_type = '51' or d.register_type = '81' or d.register_type = 'B1')");
			sql.append(" group by d.people_id, d.object_type) t ");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		sql.append(" where b.domicile_code = c.id and b.people_id = t.people_id");
		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" and substr(b.domicile_code,1,2) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2));
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" and substr(b.domicile_code,1,4) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" and substr(b.domicile_code,1,6) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6));
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" and substr(b.domicile_code,1,9) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9));
		} else { // 村
			sql.append(" and b.domicile_code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if (name != null && !"".equals(name)) {
			sql.append(" and  b.name like ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name + "%");
		}
		if (idCard != null && !"".equals(idCard)) {
			sql.append(" and  b.id_card = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		sql.append(" ORDER BY b.DOMICILE_CODE, b.NAME ");

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
		} else {
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(),
						pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}
		}

		return ds;
	}

	/**
	 * 查询优抚业务办理人员统计
	 * 
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryBusinessManage(ParameterSet pset) {
		DataSet ds = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String serviceType = (String) pset.getParameter("serviceType");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT DISTINCT V.ID_CARD, V.NAME, V.SEX, V.NATION, V.DOMICILE_CODE,\n");
		sql.append("                V.DOMICILE_TYPE, V.BIRTHDAY, V.FULL_NAME, V.SERVICE_TYPE\n"); 
		sql.append("  FROM V_BPT_QUERY_BUSINESS_MANAGE V\n"); 
		sql.append(" WHERE 1 = 1");
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" and to_date(v.apply_date, 'yyyy-mm-dd') between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}

		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" and substr(v.domicile_code,1,2) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2));
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" and substr(v.domicile_code,1,4) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" and substr(v.domicile_code,1,6) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6));
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" and substr(v.domicile_code,1,9) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9));
		} else { // 村
			sql.append(" and v.domicile_code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}

		if (name != null && !"".equals(name)) {
			sql.append(" and  v.name like ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name + "%");
		}

		if (idCard != null && !"".equals(idCard)) {
			sql.append(" and  v.id_card = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}

		if (serviceType != null && !serviceType.equals("")) {
			if (serviceType.indexOf(",") != -1) {
				String[] types = serviceType.split(",");
				for (int i = 0; i < types.length; i++) {
					if (i == 0) {
						sql.append(" AND (v.service_type = ? ");
					} else {
						sql.append(" OR v.service_type = ?");
						if (i == types.length - 1) {
							sql.append(" )");
						}
					}
					typeList.add(Types.VARCHAR);
					argsList.add(types[i]);
				}
			} else {
				sql.append(" AND v.service_type =?");
				typeList.add(Types.VARCHAR);
				argsList.add(serviceType);
			}

		}

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}

		} else {
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(),
						pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}

		}

		return ds;
	}

	/**
	 * 残疾军人伤残器械发放情况查询
	 * 
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryAssDevices(ParameterSet pset) {
		DataSet ds = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String assDevicesType = (String) pset.getParameter("assDevicesType");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT P.PEOPLE_ID, P.FAMILY_ID, P.NAME, P.ID_CARD, P.SEX, P.NATION,\n");
		sql.append("       P.DISABILITY_STATE_CODE, P.DISABILITY_NO, P.DISABILITY_LEVEL_CODE,\n"); 
		sql.append("       P.DISABILITY_CASE_CODE, C.FULL_NAME, S.APPARATUS_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, DIC_CITY C, BPT_APPLY_ASSISTIVE_DEVICES S,\n"); 
		sql.append("       BPT_APPLY_ASSISTIVE_DEVICES_PR A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = A.PEOPLE_ID AND P.DOMICILE_CODE = C.ID AND\n"); 
		sql.append("       S.APPLY_ID = A.APPLY_ID");
		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" and substr(p.domicile_code,1,2) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2));
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" and substr(p.domicile_code,1,4) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" and substr(p.domicile_code,1,6) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6));
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" and substr(p.domicile_code,1,9) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9));
		} else { // 村
			sql.append(" and p.domicile_code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}

		if (name != null && !"".equals(name)) {
			sql.append(" and  p.name like ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name + "%");
		}

		if (idCard != null && !"".equals(idCard)) {
			sql.append(" and  p.id_card = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}

		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" and to_date( a.approve_date, 'yyyy-mm-dd') between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}

		if (assDevicesType != null && !"".equals(assDevicesType)) {

			sql.append("AND EXISTS (SELECT d.device_id   FROM  bpt_people_devices d  WHERE d.apply_id = S.APPLY_ID and d.device_id  = ?)");

			typeList.add(Types.VARCHAR);
			argsList.add(assDevicesType);
		}

		sql.append(" ORDER BY p.DOMICILE_CODE, p.NAME ");

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}

		} else {
			if (pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(),
						pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}

		}

		return ds;
	}
	public DataSet queryRetired(ParameterSet pset) {

		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select baseinfo.name, baseinfo.sex,baseinfo.idcard, baseinfo.birthday,baseinfo.domiciletype,baseinfo.retiredType,");
		sql.append("  baseinfo.address,baseinfo.demobilizedno,baseinfo.workunit,baseinfo.safeguard,baseinfo.medical,  amount.moun, '' note ");
		sql.append("  from (select info.name name, info.sex sex,  info.id_card idCard,info.birthday birthday,");
		sql.append("  info.domicile_type   domiciletype,(select city.name from dic_city city ");
		sql.append(" where city.id = info.apanage_code)  address,info.RETIRED_NO demobilizedno,");
		sql.append("  info.work_unit_name workUnit, info.safeguard_type safeguard , info.medical_code  medical,");
		sql.append(" people.retired_type_code retiredType,info.people_id peopleId  ");
		sql.append(" from baseinfo_people info, bpt_people  people ");
		sql.append(" where people.people_id = info.people_id and info.RETIRED_FLAG = 1 ");
		/* 添加查询条件 */
		String xzqu = (String) pset.getParameter("xzqu");// 所属机构
		if (xzqu != null && !xzqu.equals("")) {
			if (!xzqu.substring(0, 2).equals("00")
					&& xzqu.substring(2, 4).equals("00")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 2), 12, 0)=?");// 省局
			} else if (!xzqu.substring(2, 4).equals("00")
					&& xzqu.substring(4).equals("00000000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 4), 12, 0)=?");// 市局
			} else if (!xzqu.substring(4, 6).equals("00")
					&& xzqu.substring(7, 10).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 6), 12, 0)=?");// 区县
			} else if (!xzqu.substring(7, 10).equals("000")
					&& xzqu.substring(9, 12).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 9), 12, 0)=?");// 街道
			} else {
				sql.append(" and info.domicile_code=?");// 社区
			}
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}

		String name = (String) pset.getParameter("name");// 姓名
		if (name != null && !name.equals("")) {
			sql.append(" and info.name like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		/*String pinyin = (String) pset.getParameter("pinyin");// 拼音码
		if (pinyin != null && !pinyin.equals("")) {
			sql.append(" and info.phonetic_code like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(pinyin);
		}*/

		String demobilizedno = (String) pset.getParameter("demobilizedno");// 证件编码
		if (demobilizedno != null && !demobilizedno.equals("")) {
			sql.append(" and info.RETIRED_NO like '%'||?||'%'  ");
			typeList.add(Types.VARCHAR);
			argsList.add(demobilizedno);
		}

		String idcard = (String) pset.getParameter("idCard");// 身份证号
		if (idcard != null && !idcard.equals("")) {
			sql.append(" and info.id_card like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(idcard);
		}

		String domiciletype = (String) pset.getParameter("domicileType");// 户籍类型
		if (domiciletype != null && !domiciletype.equals("")) {
			sql.append(" and info.domicile_type = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(domiciletype);
		}

		String state = (String) pset.getParameter("demobilizedState");// 优抚状态
		if (state != null && !state.equals("")) {
			sql.append(" and info.RETIRED_STATE_CODE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(state);
		}

		sql.append("  ) baseinfo  right join (select sum(detail.grant_mon_sum) moun,  detail.people_id peopleId ");
		sql.append(" from bpt_capital_detail detail ,bpt_capital_summary summary  ");
		sql.append("  where detail.register_id = summary.register_id  and detail.register_type = '81' ");
		String cxsj_q = (String) pset.getParameter("cxsj_q");// 起止时间
		String cxsj_z = (String) pset.getParameter("cxsj_z");
		if (cxsj_q != null && cxsj_z != null) {
			sql.append(" and to_date(summary.grant_date,'yyyy-mm-dd')  ");
			sql.append(" between to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			sql.append(" and to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		sql.append(" group by detail.people_id ) amount  on amount.peopleId = baseinfo.peopleId ");
		sql.append(" where baseinfo.name is not null  ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		if (pset.containsKey("limit")) {
			return this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {// 用于打印
			return this.executeDataset(sql.toString(), types, args, true);
		}
	}
	public DataSet queryMartyrOffspring(ParameterSet pset) {

		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select baseinfo.name, baseinfo.sex,baseinfo.idcard, baseinfo.birthday,baseinfo.domiciletype,baseinfo.martyrType,");
		sql.append("  baseinfo.address,baseinfo.demobilizedno,baseinfo.workunit,baseinfo.safeguard,baseinfo.medical,  amount.moun, '' note ");
		sql.append("  from (select info.name name, info.sex sex,  info.id_card idCard,info.birthday birthday,");
		sql.append("  info.domicile_type   domiciletype,(select city.name from dic_city city ");
		sql.append(" where city.id = info.apanage_code)  address,info.MARTYR_OFFSPRING_NO demobilizedno,");
		sql.append("  info.work_unit_name workUnit, info.safeguard_type safeguard , info.medical_code  medical,");
		sql.append(" people.martyr_offspring_code martyrType,info.people_id peopleId  ");
		sql.append(" from baseinfo_people info, bpt_people  people ");
		sql.append(" where people.people_id = info.people_id and info.MARTYR_OFFSPRING_FLAG = 1 ");
		/* 添加查询条件 */
		String xzqu = (String) pset.getParameter("xzqu");// 所属机构
		if (xzqu != null && !xzqu.equals("")) {
			if (!xzqu.substring(0, 2).equals("00")
					&& xzqu.substring(2, 4).equals("00")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 2), 12, 0)=?");// 省局
			} else if (!xzqu.substring(2, 4).equals("00")
					&& xzqu.substring(4).equals("00000000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 4), 12, 0)=?");// 市局
			} else if (!xzqu.substring(4, 6).equals("00")
					&& xzqu.substring(7, 10).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 6), 12, 0)=?");// 区县
			} else if (!xzqu.substring(7, 10).equals("000")
					&& xzqu.substring(9, 12).equals("000")) {
				sql.append(" and rpad(substr(info.domicile_code, 1, 9), 12, 0)=?");// 街道
			} else {
				sql.append(" and info.domicile_code=?");// 社区
			}
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}

		String name = (String) pset.getParameter("name");// 姓名
		if (name != null && !name.equals("")) {
			sql.append(" and info.name like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		/*String pinyin = (String) pset.getParameter("pinyin");// 拼音码
		if (pinyin != null && !pinyin.equals("")) {
			sql.append(" and info.phonetic_code like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(pinyin);
		}*/

		String demobilizedno = (String) pset.getParameter("demobilizedno");// 证件编码
		if (demobilizedno != null && !demobilizedno.equals("")) {
			sql.append(" and info.MARTYR_OFFSPRING_NO like '%'||?||'%'  ");
			typeList.add(Types.VARCHAR);
			argsList.add(demobilizedno);
		}

		String idcard = (String) pset.getParameter("idCard");// 身份证号
		if (idcard != null && !idcard.equals("")) {
			sql.append(" and info.id_card like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(idcard);
		}

		String domiciletype = (String) pset.getParameter("domicileType");// 户籍类型
		if (domiciletype != null && !domiciletype.equals("")) {
			sql.append(" and info.domicile_type = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(domiciletype);
		}

		String state = (String) pset.getParameter("demobilizedState");// 优抚状态
		if (state != null && !state.equals("")) {
			sql.append(" and info.MARTYR_OFFSPRING_STATE_CODE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(state);
		}

		sql.append("  ) baseinfo  right join (select sum(detail.grant_mon_sum) moun,  detail.people_id peopleId ");
		sql.append(" from bpt_capital_detail detail ,bpt_capital_summary summary  ");
		sql.append("  where detail.register_id = summary.register_id  and detail.register_type = 'B1' ");
		String cxsj_q = (String) pset.getParameter("cxsj_q");// 起止时间
		String cxsj_z = (String) pset.getParameter("cxsj_z");
		if (cxsj_q != null && cxsj_z != null) {
			sql.append(" and to_date(summary.grant_date,'yyyy-mm-dd')  ");
			sql.append(" between to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			sql.append(" and to_date(?,'yyyy-mm-dd') ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		sql.append(" group by detail.people_id ) amount  on amount.peopleId = baseinfo.peopleId ");
		sql.append(" where baseinfo.name is not null  ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		if (pset.containsKey("limit")) {
			return this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {// 用于打印
			return this.executeDataset(sql.toString(), types, args, true);
		}
	}
}
