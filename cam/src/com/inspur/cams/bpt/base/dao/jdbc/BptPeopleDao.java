package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptPeopleDao;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.comm.util.DateUtil;

/**
 * @title:BptPeopleDao
 * @description:优抚人员信息
 * @author:
 * @since:2011-05-21
 * @version:1.0
 */
/**
 * @author Administrator
 *
 */
/**
 * @author Administrator
 *
 */
/**
 * @author Administrator
 *
 */
public class BptPeopleDao extends EntityDao<BptPeople> implements IBptPeopleDao {

	public BptPeopleDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<BptPeople> getEntityClass() {
		return BptPeople.class;
	}

	/**
	 * 查询优抚对像基本信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryBPTObjectInfo(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		
		String domicileCode = (String) pset.getParameter("domicileCode");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String objectState = (String) pset.getParameter("objectState");
		String objectType = (String) pset.getParameter("objectType");
		String organCode = (String) pset.getParameter("organCode");
		String bptNo = (String) pset.getParameter("bptNo");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String ageBegin = (String) pset.getParameter("ageBegin");
		String ageEnd = (String) pset.getParameter("ageEnd");
		String isprovinceMigrate = (String) pset.getParameter("isprovinceMigrate");
		StringBuffer sqlfind = new StringBuffer();
		if (objectType != null && !objectType.equals("")) {
			
				sqlfind.append("SELECT V.PEOPLE_AGE, V.PEOPLE_ID, V.FAMILY_ID, V.DOMICILE_CODE, V.NAME,\n");
				sqlfind.append("       V.ID_CARD, V.SEX, V.NATION, V.FULL_NAME AS DOMICILE_NAME,\n"); 
				sqlfind.append("       V.OBJECT_STATE, V.OBJECT_TYPE, V.BPT_NO\n"); 
				sqlfind.append("  FROM V_BPT_OBJECT_UNION V\n"); 
				if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
					sqlfind.append("  ,bpt_province_migrate p\n"); 
				}
				sqlfind.append(" WHERE 1 = 1");
				if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
					sqlfind.append("  and p.people_id = v.people_id \n"); 
				}
			//}
		} else {// 全部
			sqlfind.append("SELECT V.PEOPLE_AGE, V.PEOPLE_ID, V.FAMILY_ID, V.DOMICILE_CODE, V.NAME,\n");
			sqlfind.append("       V.ID_CARD, V.SEX, V.NATION, V.FULL_NAME AS DOMICILE_NAME,\n"); 
			sqlfind.append("       V.OBJECT_STATE, V.OBJECT_TYPE, V.BPT_NO\n");
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sqlfind.append("  ,'1' as flag\n"); 
			}
			sqlfind.append("  FROM V_BPT_OBJECT_UNION V\n"); 
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sqlfind.append("  ,bpt_province_migrate p\n"); 
			}
			sqlfind.append(" WHERE 1 = 1");
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sqlfind.append("  and p.people_id = v.people_id \n"); 
			}
		}

		StringBuffer sqlExcel = new StringBuffer();// 导出Excel sql语句
		if (objectType != null && !objectType.equals("")) {
			
				sqlExcel.append("SELECT V.PEOPLE_AGE, V.PEOPLE_ID, V.FAMILY_ID, V.DOMICILE_CODE, V.NAME,\n");
				sqlExcel.append("       V.ID_CARD,\n"); 
				sqlExcel.append("       (CASE V.SEX\n"); 
				sqlExcel.append("          WHEN '1' THEN '男'\n"); 
				sqlExcel.append("          WHEN '2' THEN '女'\n"); 
				sqlExcel.append("        END) AS SEX, N.NAME AS NATION, V.FULL_NAME AS DOMICILE_NAME,\n"); 
				sqlExcel.append("       (CASE V.OBJECT_STATE\n"); 
				sqlExcel.append("          WHEN '1' THEN '受理'\n"); 
				sqlExcel.append("          WHEN '2' THEN '享受待遇'\n"); 
				sqlExcel.append("          WHEN '3' THEN '身份认定不享受待遇'\n"); 
				sqlExcel.append("          WHEN '4' THEN '停发'\n"); 
				sqlExcel.append("          WHEN '5' THEN '迁移'\n"); 
				sqlExcel.append("          WHEN '6' THEN '不予认定'\n"); 
				sqlExcel.append("          WHEN '7' THEN '去世'\n"); 
				sqlExcel.append("          WHEN '8' THEN '取消'\n"); 
				sqlExcel.append("          WHEN '9' THEN '中止'\n"); 
				sqlExcel.append("        END) AS OBJECT_STATE,\n"); 
				sqlExcel.append("       (CASE V.OBJECT_TYPE\n"); 
				sqlExcel.append("          WHEN '11' THEN '残疾军人'\n"); 
				sqlExcel.append("          WHEN '12' THEN '伤残国家机关工作人员'\n"); 
				sqlExcel.append("          WHEN '13' THEN '伤残人民警察'\n"); 
				sqlExcel.append("          WHEN '14' THEN '伤残民兵民工'\n"); 
				sqlExcel.append("          WHEN '15' THEN '因战因公伤残人员'\n"); 
				sqlExcel.append("          WHEN '21' THEN '烈士家属'\n"); 
				sqlExcel.append("          WHEN '22' THEN '因公牺牲军人家属'\n"); 
				sqlExcel.append("          WHEN '23' THEN '病故军人家属'\n"); 
				sqlExcel.append("          WHEN '31' THEN '在乡退伍红军老战士'\n"); 
				sqlExcel.append("          WHEN '32' THEN '在乡西路军红军老战士'\n"); 
				sqlExcel.append("          WHEN '33' THEN '红军失散人员'\n"); 
				sqlExcel.append("          WHEN '41' THEN '在乡复员军人'\n"); 
				sqlExcel.append("          WHEN '42' THEN '带病回乡复员军人'\n"); 
				sqlExcel.append("          WHEN '51' THEN '参战'\n"); 
				sqlExcel.append("          WHEN '61' THEN '参试'\n"); 
				sqlExcel.append("        END) AS OBJECT_TYPE, V.BPT_NO\n"); 
				sqlExcel.append("  FROM V_BPT_OBJECT_UNION V, DIC_NATION N\n"); 
				if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
					sqlExcel.append("  ,bpt_province_migrate p\n"); 
				}
				sqlExcel.append(" WHERE  V.NATION = N.CODE");
				if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
					sqlExcel.append("  and p.people_id = v.people_id \n"); 
				}
			//}
		} else {// 全部
			sqlExcel.append("SELECT V.PEOPLE_AGE, V.PEOPLE_ID, V.FAMILY_ID, V.DOMICILE_CODE, V.NAME,\n");
			sqlExcel.append("       V.ID_CARD,\n"); 
			sqlExcel.append("       (CASE V.SEX\n"); 
			sqlExcel.append("          WHEN '1' THEN '男'\n"); 
			sqlExcel.append("          WHEN '2' THEN '女'\n"); 
			sqlExcel.append("        END) AS SEX, N.NAME AS NATION, V.FULL_NAME AS DOMICILE_NAME,\n"); 
			sqlExcel.append("       (CASE V.OBJECT_STATE\n"); 
			sqlExcel.append("          WHEN '1' THEN '受理'\n"); 
			sqlExcel.append("          WHEN '2' THEN '享受待遇'\n"); 
			sqlExcel.append("          WHEN '3' THEN '身份认定不享受待遇'\n"); 
			sqlExcel.append("          WHEN '4' THEN '停发'\n"); 
			sqlExcel.append("          WHEN '5' THEN '迁移'\n"); 
			sqlExcel.append("          WHEN '6' THEN '不予认定'\n"); 
			sqlExcel.append("          WHEN '7' THEN '去世'\n"); 
			sqlExcel.append("          WHEN '8' THEN '取消'\n"); 
			sqlExcel.append("          WHEN '9' THEN '中止'\n"); 
			sqlExcel.append("        END) AS OBJECT_STATE,\n"); 
			sqlExcel.append("       (CASE V.OBJECT_TYPE\n"); 
			sqlExcel.append("          WHEN '11' THEN '残疾军人'\n"); 
			sqlExcel.append("          WHEN '12' THEN '伤残国家机关工作人员'\n"); 
			sqlExcel.append("          WHEN '13' THEN '伤残人民警察'\n"); 
			sqlExcel.append("          WHEN '14' THEN '伤残民兵民工'\n"); 
			sqlExcel.append("          WHEN '15' THEN '因战因公伤残人员'\n"); 
			sqlExcel.append("          WHEN '21' THEN '烈士家属'\n"); 
			sqlExcel.append("          WHEN '22' THEN '因公牺牲军人家属'\n"); 
			sqlExcel.append("          WHEN '23' THEN '病故军人家属'\n"); 
			sqlExcel.append("          WHEN '31' THEN '在乡退伍红军老战士'\n"); 
			sqlExcel.append("          WHEN '32' THEN '在乡西路军红军老战士'\n"); 
			sqlExcel.append("          WHEN '33' THEN '红军失散人员'\n"); 
			sqlExcel.append("          WHEN '41' THEN '在乡复员军人'\n"); 
			sqlExcel.append("          WHEN '42' THEN '带病回乡复员军人'\n"); 
			sqlExcel.append("          WHEN '51' THEN '参战'\n"); 
			sqlExcel.append("          WHEN '61' THEN '参试'\n"); 
			sqlExcel.append("        END) AS OBJECT_TYPE, V.BPT_NO\n"); 
			sqlExcel.append("  FROM V_BPT_OBJECT_UNION V, DIC_NATION N\n"); 
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sqlExcel.append("  ,bpt_province_migrate p\n"); 
			}
			sqlExcel.append(" WHERE  V.NATION = N.CODE");
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sqlExcel.append("  and p.people_id = v.people_id \n"); 
			}
		}

		StringBuffer newSql = new StringBuffer();
		String isAll = (String) pset.getParameter("isAll");
		// 判定是否是导入excel
		if ("all".equals(isAll) || !pset.containsKey("limit")) {// 导入excel所用sql
			newSql.append(sqlExcel);
		} else {
			newSql.append(sqlfind);
		}
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			if (domicileCode != null && !domicileCode.equals("")) {
				if (!domicileCode.substring(0, 2).equals("00")
						&& domicileCode.substring(2, 4).equals("00")) {
					newSql.append(" AND p.OUT_DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				} else if (!domicileCode.substring(2, 4).equals("00")
						&& domicileCode.substring(4).equals("00000000")) {
					newSql.append(" AND p.OUT_DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				} else if (!domicileCode.substring(4, 6).equals("00")
						&& domicileCode.substring(6, 9).equals("000")) {
					newSql.append(" AND p.OUT_DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				} else if (!domicileCode.substring(6, 9).equals("000")
						&& domicileCode.substring(9, 12).equals("000")) {
					newSql.append(" AND p.OUT_DOMICILE_CODE like ?");// 街道
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				} else {
					newSql.append(" AND p.OUT_DOMICILE_CODE=?");// 社区
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			} else {
				if (!organCode.substring(0, 2).equals("00")
						&& organCode.substring(2, 4).equals("00")) {
					newSql.append(" AND  p.OUT_DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				} else if (!organCode.substring(2, 4).equals("00")
						&& organCode.substring(4, 6).equals("00")) {
					newSql.append(" AND p.OUT_DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4)+"%");
				} else {
					newSql.append(" AND p.OUT_DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			} 
		}else {
		// domicileCode为暂时的，挂行政区划代码后，需写在上面
			if (domicileCode != null && !domicileCode.equals("")) {
				if (!domicileCode.substring(0, 2).equals("00")
						&& domicileCode.substring(2, 4).equals("00")) {
					newSql.append(" AND V.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				} else if (!domicileCode.substring(2, 4).equals("00")
						&& domicileCode.substring(4).equals("00000000")) {
					newSql.append(" AND V.DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				} else if (!domicileCode.substring(4, 6).equals("00")
						&& domicileCode.substring(6, 9).equals("000")) {
					newSql.append(" AND V.DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				} else if (!domicileCode.substring(6, 9).equals("000")
						&& domicileCode.substring(9, 12).equals("000")) {
					newSql.append(" AND V.DOMICILE_CODE like ?");// 街道
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				} else {
					newSql.append(" AND V.DOMICILE_CODE=?");// 社区
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			} else {
				if (!organCode.substring(0, 2).equals("00")
						&& organCode.substring(2, 4).equals("00")) {
					newSql.append(" AND  V.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				} else if (!organCode.substring(2, 4).equals("00")
						&& organCode.substring(4, 6).equals("00")) {
					newSql.append(" AND V.DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4)+"%");
				} else {
					newSql.append(" AND V.DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			}
		}
		if (name != null && !name.equals("")) {
			newSql.append(" AND V.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(name + "%");
		}

		if (idCard != null && !idCard.equals("")) {
			newSql.append(" AND V.ID_CARD LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard + "%");
		}

		if (bptNo != null && !bptNo.equals("")) {
			newSql.append(" AND V.BPT_NO LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(bptNo + "%");
		}

		if (objectState != null && !objectState.equals("")) {
			newSql.append(" AND V.OBJECT_STATE = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(objectState);
		}
		if (objectType != null && !objectType.equals("")) {
			/* 取出节点ID，并组合sql */
			String[] list = new String[20];
			list = objectType.split(",");
			newSql.append(" AND (");
			for (int i = 0; i < list.length; i++) {
				newSql.append(" V.OBJECT_TYPE like ?");
				typeList.add(Types.VARCHAR);
				argsList.add(list[i] + "%");
				if (i != list.length - 1) {
					newSql.append(" OR ");
				} else {
					newSql.append(" )");
				}
			}
		}

		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			
			/*newSql.append(" AND TO_DATE(V.APPROVE_DATE, 'YYYY-MM-DD') BETWEEN TO_DATE(?, 'YYYY-MM-DD')\n");
			newSql.append(" AND TO_DATE(?, 'YYYY-MM-DD') ");*/
			
			newSql.append(" AND V.APPROVE_DATE BETWEEN ? AND ?\n");
			
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}

		if (ageBegin != null && !"".equals(ageBegin)) {
			newSql.append(" AND V.PEOPLE_AGE >= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageBegin));
		}

		if (ageEnd != null && !"".equals(ageEnd)) {
			newSql.append(" AND V.PEOPLE_AGE <= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageEnd));
		}

		//newSql.append(" ORDER BY V.DOMICILE_CODE,V.NAME,V.OBJECT_TYPE");

		DataSet ds = null;
		int[] types = null;
		Object[] args = null;
		if (typeList.size() != 0 && argsList.size() != 0) {
			types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			args = argsList.toArray(new Object[argsList.size()]);
		}
		// 判定是否是Excel执行的方法
		if ("all".equals(isAll) || !pset.containsKey("limit")) {// 导出Excel用的方法
			ds = this.executeDataset(newSql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(newSql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
	
	/**
	 * 查询优抚对像申请信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleService(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String domicileCode = (String) pset.getParameter("domicileCode");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String objectState = (String) pset.getParameter("objectState");
		String organCode = (String) pset.getParameter("organCode");
		String objectType = (String) pset.getParameter("objectType");
		String serviceType = (String) pset.getParameter("serviceType");
		StringBuffer sql = new StringBuffer();
		
		if(serviceType == null || serviceType.equals("")){//查询非审批人员
			sql.append("select  v.PEOPLE_AGE, v.PEOPLE_ID,  v.FAMILY_ID, v.DOMICILE_CODE,  v.NAME,\n");
			sql.append("       v.ID_CARD, v.SEX,  v.NATION, v.FULL_NAME     AS DOMICILE_NAME, v.OBJECT_STATE,\n"); 
			sql.append("       v.OBJECT_TYPE, v.BPT_NO \n"); 
			sql.append("  from V_BPT_OBJECT_UNION V\n"); 
			sql.append("where v.people_id not in(select c.people_id from Bpt_State_Change c where c.change_state_pre='1' ) ");
		}else{//查询审批人员

			sql.append("select  v.PEOPLE_AGE, v.PEOPLE_ID,  v.FAMILY_ID, v.DOMICILE_CODE,  v.NAME,\n");
			sql.append("       v.ID_CARD, v.SEX,  v.NATION, v.FULL_NAME     AS DOMICILE_NAME, v.OBJECT_STATE,\n"); 
			sql.append("       v.OBJECT_TYPE, v.BPT_NO,f.act,f.actdef_name ,f.apply_id, s.service_type,s.st\n"); 
			sql.append("  from\n"); 
			sql.append("(select l.act,r.actdef_name, l.apply_id from (select max(h.create_time)as act,h.apply_id  from BPT_APPLY_HISTORY h group by h.apply_id) l,BPT_APPLY_HISTORY r\n"); 
			sql.append("where r.apply_id(+)= l.apply_id and r.create_time=l.act) f ,V_BPT_OBJECT_UNION V,\n"); 
			if("15".equals(serviceType)||"22".equals(serviceType)||"42".equals(serviceType)||"46".equals(serviceType)||"52".equals(serviceType)||"62".equals(serviceType)||"82".equals(serviceType)||"B2".equals(serviceType)){
				sql.append("(select p.apply_id ,p.people_id, t.name as st, p.service_type from BPT_APPLY_INTOPROVINCE p, dic_bpt_service_type t where  t.code(+)= p.service_type) s--申请迁入\n"); 
			}else if("11".equals(serviceType)||"12".equals(serviceType)||"13".equals(serviceType)||"14".equals(serviceType)){
				sql.append("(select p.apply_id ,p.people_id, t.name as st, p.service_type from bpt_apply_disability p, dic_bpt_service_type t where  t.code(+)= p.service_type) s--申请伤残\n"); 
			}else if("17".equals(serviceType)){
				sql.append("(select p.apply_id ,p.people_id, '伤残人员伤残辅助器械申请' as st, '17' as service_type from bpt_apply_assistive_devices_pr p, dic_bpt_service_type t where  t.code(+)= p.service_type) s----器械申请\n"); 
			}else if("21".equals(serviceType)||"51".equals(serviceType)||"61".equals(serviceType)){
				sql.append("(select p.apply_id ,p.people_id, t.name as st, p.service_type from BPT_APPLY_DEPENDANT p, dic_bpt_service_type t where  t.code(+)= p.service_type) s--三属申请 cz cs\n"); 
			}else if("41".equals(serviceType)||"45".equals(serviceType)){
				sql.append("(select p.apply_id ,p.people_id, t.name as st, p.service_type from BPT_APPLY_DEMOBILIZED p, dic_bpt_service_type t where  t.code(+)= p.service_type) s--申请 zx db\n"); 
			}else if("19".equals(serviceType)||"25".equals(serviceType)||"4B".equals(serviceType)||"4A".equals(serviceType)||"55".equals(serviceType)||"65".equals(serviceType)||"84".equals(serviceType)||"B4".equals(serviceType)){
				sql.append("(select p.apply_id ,p.people_id, t.name as st, p.service_type from BPT_APPLY_EMIGRATION p, dic_bpt_service_type t where  t.code(+)= p.service_type) s--申请迁出\n"); 
			}else if("16".equals(serviceType)||"23".equals(serviceType)||"43".equals(serviceType)||"47".equals(serviceType)||"53".equals(serviceType)||"63".equals(serviceType)||"83".equals(serviceType)||"B3".equals(serviceType)){ 
				sql.append("(select p.apply_id ,p.people_id, t.name as st, p.service_type from BPT_PROVINCE_MIGRATE p, dic_bpt_service_type t where  t.code(+)= p.service_type) s--申请省内迁移\n"); 
			}else if("B1".equals(serviceType)||"81".equals(serviceType)){ 
				sql.append("(select p.apply_id ,p.people_id, t.name as st, p.service_type from BPT_APPLY_MARTYR_OFFSPRING p, dic_bpt_service_type t where  t.code(+)= p.service_type) s--申请 烈属子女，60退役士兵\n"); 
			}else if("A1".equals(serviceType)){
				sql.append("(select p.apply_id ,p.people_id,'临时救助申请' as st,'A1' as service_type from BPT_TEMPORARY_HELP p ) s--申请 临时\n"); 
			}
			sql.append("where f.apply_id= s.apply_id and s.people_id = v.PEOPLE_ID");
		}
		
		// domicileCode为暂时的，挂行政区划代码后，需写在上面
		if (domicileCode != null && !domicileCode.equals("")) {
			if (!domicileCode.substring(0, 2).equals("00")
					&& domicileCode.substring(2, 4).equals("00")) {
				sql.append(" AND V.DOMICILE_CODE like ?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 2)+"%");
			} else if (!domicileCode.substring(2, 4).equals("00")
					&& domicileCode.substring(4).equals("00000000")) {
				sql.append(" AND V.DOMICILE_CODE like ?");// 市局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 4)+"%");
			} else if (!domicileCode.substring(4, 6).equals("00")
					&& domicileCode.substring(6, 9).equals("000")) {
				sql.append(" AND V.DOMICILE_CODE like ?");// 区县
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6)+"%");
			} else if (!domicileCode.substring(6, 9).equals("000")
					&& domicileCode.substring(9, 12).equals("000")) {
				sql.append(" AND V.DOMICILE_CODE like ?");// 街道
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 9)+"%");
			} else {
				sql.append(" AND V.DOMICILE_CODE=?");// 社区
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode);
			}
		} else {
			if (!organCode.substring(0, 2).equals("00")
					&& organCode.substring(2, 4).equals("00")) {
				sql.append(" AND  V.DOMICILE_CODE like ?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2)+"%");
			} else if (!organCode.substring(2, 4).equals("00")
					&& organCode.substring(4, 6).equals("00")) {
				sql.append(" AND V.DOMICILE_CODE like ?");// 市局
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4)+"%");
			} else {
				sql.append(" AND V.DOMICILE_CODE like ?");// 区县
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6)+"%");
			}
		}
		if (name != null && !name.equals("")) {
			sql.append(" AND V.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(name + "%");
		}

		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND V.ID_CARD LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard + "%");
		}

		if (objectType != null && !objectType.equals("")) {
			sql.append(" AND v.OBJECT_TYPE= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(objectType);
		}
		
		if (serviceType != null && !serviceType.equals("")) {
			sql.append(" AND s.service_type =?");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		
		if (objectState != null && !objectState.equals("")) {
			sql.append(" AND V.OBJECT_STATE = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(objectState);
		}

		

		//sql.append(" ORDER BY V.DOMICILE_CODE,V.NAME,V.OBJECT_TYPE");

		DataSet ds = null;
		int[] types = null;
		Object[] args = null;
		if (typeList.size() != 0 && argsList.size() != 0) {
			types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			args = argsList.toArray(new Object[argsList.size()]);
		}
		ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		return ds;
	}
	/**
	 * 查询人员各种审批信息
	 * 
	 * @return
	 */
	public DataSet queryApplyInfo(ParameterSet pset) {
		String peopleId = (String) pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT PE.NAME, B.APPLYID, B.SERVICETYPE, B.APPROVEDATE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE PE,\n"); 
		sql.append("       (\n"); 
		//在乡
		sql.append("        SELECT DD.APPLY_ID AS APPLYID, BPD.APPROVAL_DATE AS APPROVEDATE,\n"); 
		sql.append("                DD.SERVICE_TYPE AS SERVICETYPE\n"); 
		sql.append("           FROM BPT_APPLY_DEMOBILIZED DD, BPT_PEOPLE_DEMOBILIZED BPD\n"); 
		sql.append("          WHERE DD.COMMIT_FLAG = ? AND DD.PEOPLE_ID = BPD.PEOPLE_ID AND\n"); 
		sql.append("                DD.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		//带病回乡
		sql.append("         SELECT DD.APPLY_ID AS APPLYID, BPDI.APPROVAL_DATE AS APPROVEDATE,\n"); 
		sql.append("                DD.SERVICE_TYPE AS SERVICETYPE\n"); 
		sql.append("           FROM BPT_APPLY_DEMOBILIZED DD, BPT_PEOPLE_DEMOBILIZED_ILLNESS BPDI\n"); 
		sql.append("          WHERE DD.COMMIT_FLAG = ? AND DD.PEOPLE_ID = BPDI.PEOPLE_ID AND\n"); 
		sql.append("                DD.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		//伤残
		sql.append("         SELECT DY.APPLY_ID AS APPLYID, DY.PROVINCE_APPROVE_DATE AS APPROVEDATE,\n"); 
		sql.append("                DY.SERVICE_TYPE AS SERVICETYPE\n"); 
		sql.append("           FROM BPT_APPLY_DISABILITY DY, BPT_PEOPLE_DISABILITY BPY\n"); 
		sql.append("          WHERE DY.COMMIT_FLAG = ? AND DY.PEOPLE_ID = BPY.PEOPLE_ID AND\n"); 
		sql.append("                DY.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		//省内迁移

		sql.append("select t.APPLYID,t.APPROVEDATE,t.SERVICETYPE from \n");
		sql.append("(SELECT ME.APPLY_ID           AS APPLYID, \n"); 
		sql.append("       BSC.CHANGE_STATE_DATE AS APPROVEDATE, \n"); 
		sql.append("       ME.SERVICE_TYPE       AS SERVICETYPE \n"); 
		sql.append("  FROM BPT_PROVINCE_MIGRATE ME, BPT_STATE_CHANGE BSC \n"); 
		sql.append(" WHERE ME.COMMIT_FLAG = ?\n"); 
		sql.append("   AND ME.PEOPLE_ID = BSC.PEOPLE_ID \n"); 
		sql.append("   AND ME.SERVICE_TYPE = BSC.OBJECT_TYPE \n"); 
		sql.append("   AND ME.PEOPLE_ID = ? \n"); 
		sql.append("   and bsc.change_state_pre='5' \n"); 
		sql.append("   and bsc.change_state_date=me.apply_date )  t \n"); 
		/*sql.append(" where t.APPROVEDATE in (select max(APPROVEDATE) from \n"); 
		sql.append("(SELECT ME.APPLY_ID           AS APPLYID, \n"); 
		sql.append("       BSC.CHANGE_STATE_DATE AS APPROVEDATE, \n"); 
		sql.append("       ME.SERVICE_TYPE       AS SERVICETYPE \n"); 
		sql.append("  FROM BPT_PROVINCE_MIGRATE ME, BPT_STATE_CHANGE BSC \n"); 
		sql.append(" WHERE ME.COMMIT_FLAG = ? \n"); 
		sql.append("   AND ME.PEOPLE_ID = BSC.PEOPLE_ID \n"); 
		sql.append("   AND ME.SERVICE_TYPE = BSC.OBJECT_TYPE \n"); 
		sql.append("   AND ME.PEOPLE_ID = ?) \n"); 
		sql.append("   group by applyid) ");*/
		sql.append("         UNION ALL\n"); 
		//迁入
		sql.append("         SELECT IE.APPLY_ID AS APPLYID, BSC.CHANGE_STATE_DATE AS APPROVEDATE,\n"); 
		sql.append("                IE.SERVICE_TYPE AS SERVICETYPE\n"); 
		sql.append("           FROM BPT_APPLY_INTOPROVINCE IE, BPT_STATE_CHANGE BSC\n"); 
		sql.append("          WHERE IE.COMMIT_FLAG = ? AND IE.PEOPLE_ID = BSC.PEOPLE_ID AND\n"); 
		sql.append("                IE.SERVICE_TYPE = BSC.OBJECT_TYPE AND IE.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		//三属
		sql.append("         SELECT BAT.APPLY_ID AS APPLYID, BP.APPROVAL_DATE AS APPROVEDATE,\n"); 
		sql.append("                BAT.SERVICE_TYPE AS SERVICETYPE\n"); 
		sql.append("           FROM BPT_APPLY_DEPENDANT BAT, BPT_PEOPLE_DEPENDANT BP\n"); 
		sql.append("          WHERE BAT.COMMIT_FLAG = ? AND BAT.PEOPLE_ID = BP.PEOPLE_ID AND\n"); 
		sql.append("                BAT.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		// 参战
		sql.append("         SELECT BAT.APPLY_ID AS APPLYID, BPWR.APPROVAL_DATE AS APPROVEDATE,\n"); 
		sql.append("                BAT.SERVICE_TYPE AS SERVICETYPE\n"); 
		sql.append("           FROM BPT_APPLY_DEPENDANT BAT, BPT_PEOPLE_WAR BPWR\n"); 
		sql.append("          WHERE BAT.COMMIT_FLAG = ? AND BAT.PEOPLE_ID = BPWR.PEOPLE_ID AND\n"); 
		sql.append("                BAT.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		// 参试
		sql.append("         SELECT BAT.APPLY_ID AS APPLYID, BPTD.APPROVAL_DATE AS APPROVEDATE,\n"); 
		sql.append("                BAT.SERVICE_TYPE AS SERVICETYPE\n"); 
		sql.append("           FROM BPT_APPLY_DEPENDANT BAT, BPT_PEOPLE_TESTED BPTD\n"); 
		sql.append("          WHERE BAT.COMMIT_FLAG = ? AND BAT.PEOPLE_ID = BPTD.PEOPLE_ID AND\n"); 
		sql.append("                BAT.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		sql.append("         SELECT EN.APPLY_ID AS APPLYID, BSC.CHANGE_STATE_DATE AS APPROVEDATE,\n"); 
		sql.append("                EN.SERVICE_TYPE AS SERVICETYPE\n"); 
		sql.append("           FROM BPT_APPLY_EMIGRATION EN, BPT_STATE_CHANGE BSC\n"); 
		sql.append("          WHERE EN.COMMIT_FLAG = ? AND EN.PEOPLE_ID = BSC.PEOPLE_ID AND\n"); 
		sql.append("                EN.SERVICE_TYPE = BSC.OBJECT_TYPE AND EN.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		sql.append("         SELECT AD.APPLY_ID AS APPLYID,ADP.APPROVE_DATE AS APPROVEDATE,\n"); 
		sql.append("                '17' AS SERVICETYPE \n"); 
		sql.append("           FROM BPT_APPLY_ASSISTIVE_DEVICES AD,\n"); 
		sql.append("                BPT_APPLY_ASSISTIVE_DEVICES_PR ADP \n"); 
		sql.append("          WHERE AD.COMMIT_FLAG = ? AND AD.APPLY_ID = ADP.APPLY_ID\n"); 
		sql.append("            AND AD.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		//老烈士子女
		sql.append("         SELECT AMO.APPLY_ID AS APPLYID, MO.APPROVAL_DATE AS APPROVEDATE,\n"); 
		sql.append("                'B1' AS SERVICETYPE \n"); 
		sql.append("           FROM BPT_PEOPLE_MARTYR_OFFSPRING MO,\n"); 
		sql.append("                BPT_APPLY_MARTYR_OFFSPRING AMO \n"); 
		sql.append("          WHERE MO.PEOPLE_ID = AMO.PEOPLE_ID AND AMO.COMMIT_FLAG = ?\n"); 
		sql.append("          AND MO.PEOPLE_ID = ?\n"); 
		sql.append("         UNION ALL\n"); 
		//60岁退役士兵
		sql.append("         SELECT MO.APPLY_ID AS APPLYID, RS.APPROVAL_DATE AS APPROVEDATE,\n"); 
		sql.append("                '81' AS SERVICETYPE \n"); 
		sql.append("           FROM BPT_PEOPLE_RETIRED_SOLDIER RS,\n"); 
		sql.append("                BPT_APPLY_MARTYR_OFFSPRING MO \n"); 
		sql.append("          WHERE RS.PEOPLE_ID = MO.PEOPLE_ID AND MO.COMMIT_FLAG = ?\n"); 
		sql.append("          AND RS.PEOPLE_ID = ?) B\n"); 
		sql.append(" WHERE PE.PEOPLE_ID = ?\n"); 
		sql.append(" ORDER BY APPROVEDATE DESC");
		int[] types = new int[25];
		Object[] args = new Object[25];
		for (int i = 0; i < 23; i=i+2) {
			types[i] = Types.VARCHAR;
			args[i] = "1";
		}
		for (int i = 1; i < 24; i=i+2) {
			types[i] = Types.VARCHAR;
			args[i] = peopleId;
		}
		types[24] = Types.VARCHAR;
		args[24] = peopleId;
		DataSet ds = this.executeDataset(sql.toString(), types, args, true);
		return ds;
	}

	/**
	 * 查询优抚伤残减员人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDecreaseBpt(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String serviceType = (String) pset.getParameter("serviceType");
		String objectType = (String) pset.getParameter("objectType");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT PEOPLE_ID, FAMILY_ID, DOMICILE_CODE, NAME, PHOTO_ID, ID_CARD, SEX,\n");
		sql.append("       NATION, FULL_NAME AS DICNAME, STATE_CODE, SERVICETYPE AS SERVICE_TYPE\n"); 
		sql.append("  FROM V_BPT_QUERY_DECREASE V\n"); 
		//sql.append(" WHERE ((V.CHANGE_STATE_PRE = '2' AND V.CHANGE_STATE_SUF = '7'");
		sql.append(" WHERE  (");
		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" v.domicile_code like ? or v.out_domicile_code like ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2)+"%");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2)+"%");
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" v.domicile_code like ? or v.out_domicile_code like ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4)+"%");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4)+"%");
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" v.domicile_code like ? or v.out_domicile_code like ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6)+"%");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6)+"%");
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" v.domicile_code like ? or v.out_domicile_code like ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9)+"%");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9)+"%");
		} else { // 村
			sql.append(" v.domicile_code = ? or v.out_domicile_code=?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}

		sql.append(") ");

		if (serviceType != null && !"".equals(serviceType)) {
			if (serviceType.indexOf(",") != -1) {
				String[] serviceTypes = serviceType.split(",");
				for (int i = 0; i < serviceTypes.length; i++) {
					if (i == 0) {
						sql.append(" AND (v.serviceType = ? ");
					} else {
						sql.append(" OR v.serviceType = ?");
						if (i == serviceTypes.length - 1) {
							sql.append(" )");
						}
					}
					typeList.add(Types.VARCHAR);
					argsList.add(serviceTypes[i]);
				}
			} else {
				sql.append(" AND v.serviceType =?");
				typeList.add(Types.VARCHAR);
				argsList.add(serviceType);
			}
		}

		if (objectType != null && !"".equals(objectType)) {
			if (objectType.indexOf(",") != -1) {
				String[] objectTypes = objectType.split(",");
				for (int i = 0; i < objectTypes.length; i++) {
					if ("6".equals(objectTypes[i])||"B".equals(objectTypes[i])) {
						if (i == 0) {
							sql.append(" AND (v.objectType like ? ");
						} else {
							sql.append(" OR v.objectType like ?");
							if (i == objectTypes.length - 1) {
								sql.append(" )");
							}
						}
						typeList.add(Types.VARCHAR);
						argsList.add(objectTypes[i] + "%");
					} else {
						if (i == 0) {
							sql.append(" AND (v.objectType = ? ");
						} else {
							sql.append(" OR v.objectType = ?");
							if (i == objectTypes.length - 1) {
								sql.append(" )");
							}
						}
						typeList.add(Types.VARCHAR);
						argsList.add(objectTypes[i]);
					}
				}
			} else {
				sql.append(" AND v.objectType =?");
				typeList.add(Types.VARCHAR);
				argsList.add(objectType);
			}
		}

		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" AND TO_DATE(V.CHANGE_STATE_DATE, 'YYYY-MM-DD') BETWEEN TO_DATE(?, 'YYYY-MM-DD')\n");
			sql.append(" AND TO_DATE(?, 'YYYY-MM-DD') ");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		sql.append(" ORDER BY v.DOMICILE_CODE,v.NAME");

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
		} else {
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
						.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}
		}
		return ds;
	}

	/**
	 * 查询优抚增员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryIncreaseBpt(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String serviceType = (String) pset.getParameter("serviceType");
		String objectType = (String) pset.getParameter("objectType");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT PEOPLE_ID, FAMILY_ID, DOMICILE_CODE, NAME, PHOTO_ID, ID_CARD, SEX,\n");
		sql.append("       NATION, DICNAME, STATE_CODE, SERVICE_TYPE\n"); 
		sql.append("  FROM V_BPT_QUERY_INCEARSE V\n"); 
		sql.append(" WHERE 1 = 1");
		if (startTime == null || "".equals(startTime)) {
			startTime = "1900-01-01";
		}
		if (endTime == null || "".equals(endTime)) {
			endTime = DateUtil.getYear() + "-12-31";
		}
		sql.append(" and ((to_date(approve_date,'yyyy-mm-dd') between to_date(?,'yyyy-mm-dd') and to_date(?,'yyyy-mm-dd') and ");
		typeList.add(Types.VARCHAR);
		argsList.add(startTime);
		typeList.add(Types.VARCHAR);
		argsList.add(endTime);

		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" domicile_code like ?) or (in_domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2)+"%");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2)+"%");
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" domicile_code like ?) or (in_domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4)+"%");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4)+"%");
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" domicile_code like ?) or (in_domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6)+"%");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6)+"%");
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" domicile_code like ?) or (in_domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9)+"%");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9)+"%");
		} else { // 村
			sql.append(" domicile_code=?) or (in_domicile_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}

		sql.append(" and to_date(change_date,'yyyy-mm-dd') between to_date(?,'yyyy-mm-dd') and to_date(?,'yyyy-mm-dd')))");
		typeList.add(Types.VARCHAR);
		argsList.add(startTime);
		typeList.add(Types.VARCHAR);
		argsList.add(endTime);

		if (serviceType != null && !"".equals(serviceType)) {
			if (serviceType.indexOf(",") != -1) {
				String[] serviceTypes = serviceType.split(",");
				for (int i = 0; i < serviceTypes.length; i++) {
					if (i == 0) {
						sql.append(" AND (v.service_type = ? ");
					} else {
						sql.append(" OR v.service_type = ?");
						if (i == serviceTypes.length - 1) {
							sql.append(" )");
						}
					}
					typeList.add(Types.VARCHAR);
					argsList.add(serviceTypes[i]);
				}
			} else {
				sql.append(" AND v.service_type =?");
				typeList.add(Types.VARCHAR);
				argsList.add(serviceType);
			}
		}

		if (objectType != null && !"".equals(objectType)) {
			if (objectType.indexOf(",") != -1) {
				String[] objectTypes = objectType.split(",");
				for (int i = 0; i < objectTypes.length; i++) {
					if ("6".equals(objectTypes[i])||"B".equals(objectTypes[i])) {
						if (i == 0) {
							sql.append(" AND (v.object_type like ? ");
						} else {
							sql.append(" OR v.object_type like ?");
							if (i == objectTypes.length - 1) {
								sql.append(" )");
							}
						}
						typeList.add(Types.VARCHAR);
						argsList.add(objectTypes[i] + "%");
					} else {
						if (i == 0) {
							sql.append(" AND (v.object_type = ? ");
						} else {
							sql.append(" OR v.object_type = ?");
							if (i == objectTypes.length - 1) {
								sql.append(" )");
							}
						}
						typeList.add(Types.VARCHAR);
						argsList.add(objectTypes[i]);
					}
				}
			} else {
				sql.append(" AND v.object_type =?");
				typeList.add(Types.VARCHAR);
				argsList.add(objectType);
			}
		}

		sql.append(" ORDER BY v.DOMICILE_CODE,v.NAME");

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
			
		} else {
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
						.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(),true);
			}
		}

		return ds;
	}

	/**
	 * 查询人口数量
	 * 
	 * @return
	 */
	public DataSet queryPeopleNumInfo(ParameterSet pset) {
		String familyId = (String) pset.getParameter("familyId");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT ALLPEOPLE, OLD, CHILD\n");
		sql.append("  FROM (SELECT COUNT(*) AS ALLPEOPLE\n"); 
		sql.append("           FROM BASEINFO_PEOPLE T\n"); 
		sql.append("          WHERE T.FAMILY_ID = ?) A,\n"); 
		sql.append("       (SELECT COUNT(*) AS OLD\n"); 
		sql.append("           FROM BASEINFO_PEOPLE P\n"); 
		sql.append("          WHERE P.FAMILY_ID = ? AND GETAGE(P.BIRTHDAY) > '60') B,\n"); 
		sql.append("       (SELECT COUNT(*) AS CHILD\n"); 
		sql.append("           FROM BASEINFO_PEOPLE P\n"); 
		sql.append("          WHERE P.FAMILY_ID = ? AND GETAGE(P.BIRTHDAY) < '18') C");
		DataSet ds = this.executeDataset(sql.toString(), new int[] {
				Types.VARCHAR, Types.VARCHAR, Types.VARCHAR }, new Object[] {
				familyId, familyId, familyId }, true);
		return ds;
	}

	// 修改人员信息后，修改其他关联表中的相关信息，只修改审批之前表
	public void updatePeopleRelatedInfor(ParameterSet pset, Record rd) {
		String applyId = (String) pset.getParameter("applyId");
		String serviceType = (String) pset.getParameter("serviceType");
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		String name = (String) rd.get("name");
		String sex = (String) rd.get("sex");
		String birthday = (String) rd.get("birthday");
		String idCard = (String) rd.get("idCard");
		String domicileCode = (String) rd.get("domicileCode");
		String address = (String) rd.get("address");
		String workUnitName = (String) rd.get("workUnitName");
		// 伤残业务
		if ("11".equals(serviceType)) {
			sql.append("UPDATE BPT_APPLY_DISABILITY_NOTICE T\n");
			sql.append("   SET T.NAME = ?\n"); 
			sql.append(" WHERE T.APPLY_ID = (SELECT D.APPLY_ID\n"); 
			sql.append("                       FROM BPT_APPLY_DISABILITY D\n"); 
			sql.append("                      WHERE T.APPLY_ID = D.APPLY_ID AND T.APPLY_ID = ? AND\n"); 
			sql.append("                            D.COMMIT_FLAG != ?)");
			this.executeUpdate(sql.toString(), new int[] { Types.VARCHAR, Types.VARCHAR,
					Types.VARCHAR }, new Object[] { name, applyId, 1 });

			sql2.append("UPDATE BPT_DISABILITY_IDENTI T\n");
			sql2.append("   SET T.NAME           = ?,\n"); 
			sql2.append("       T.SEX            = ?,\n"); 
			sql2.append("       T.BIRTHDAY       = ?,\n"); 
			sql2.append("       T.ID_CARD        = ?,\n"); 
			sql2.append("       T.DOMICILE_CODE  = ?,\n"); 
			sql2.append("       T.ADDRESS        = ?,\n"); 
			sql2.append("       T.WORK_UNIT_NAME = ?\n"); 
			sql2.append(" WHERE T.APPLY_ID = (SELECT D.APPLY_ID\n"); 
			sql2.append("                       FROM BPT_APPLY_DISABILITY D\n"); 
			sql2.append("                      WHERE T.APPLY_ID = D.APPLY_ID AND T.APPLY_ID = ? AND\n"); 
			sql2.append("                            D.COMMIT_FLAG != ?)");
			this.executeUpdate(sql2.toString(), new int[] { Types.VARCHAR, Types.VARCHAR,
					Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					Types.VARCHAR, Types.VARCHAR, Types.VARCHAR },
					new Object[] { name, sex, birthday, idCard, domicileCode,
							address, workUnitName, applyId, 1 });
		} else if ("14".equals(serviceType)) { // 退役军人伤残抚恤关系迁入
			sql.append("UPDATE BPT_DISABILITY_IDENTI T\n");
			sql.append("   SET T.NAME           = ?,\n"); 
			sql.append("       T.SEX            = ?,\n"); 
			sql.append("       T.BIRTHDAY       = ?,\n"); 
			sql.append("       T.ID_CARD        = ?,\n"); 
			sql.append("       T.DOMICILE_CODE  = ?,\n"); 
			sql.append("       T.ADDRESS        = ?,\n"); 
			sql.append("       T.WORK_UNIT_NAME = ?\n"); 
			sql.append(" WHERE T.APPLY_ID = (SELECT D.APPLY_ID\n"); 
			sql.append("                       FROM BPT_APPLY_DISABILITY D\n"); 
			sql.append("                      WHERE T.APPLY_ID = D.APPLY_ID AND T.APPLY_ID = ? AND\n"); 
			sql.append("                            D.COMMIT_FLAG != ?)");
			this.executeUpdate(sql.toString(), new int[] { Types.VARCHAR, Types.VARCHAR,
					Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					Types.VARCHAR, Types.VARCHAR, Types.VARCHAR },
					new Object[] { name, sex, birthday, idCard, domicileCode,
							address, workUnitName, applyId, 1 });
		}
	}
	
	public String  getMsgForNOPrint (ParameterSet pset){
		String peopleId = (String) pset.getParameter("peopleId");
		String type = (String) pset.getParameter("type");
		StringBuffer sql = new StringBuffer();
		StringBuffer str = new StringBuffer();
		sql.append("select b.people_id,b.id_card,d.full_name,\n");
		if(type!=null&&"disability".equals(type)){
			sql.append("   b.disability_no as bpt_no\n"); 
			sql.append(" ,(case bd.DISABILITY_LEVEL_CODE when '01' then '一级' when '02' then '二级'\n"); 
			sql.append("       when '03' then '三级' when '04' then '四级'\n"); 
			sql.append("       when '05' then '五级' when '06' then '六级'\n"); 
			sql.append("       when '07' then '七级' when '08' then '八级'\n"); 
			sql.append("       when '09' then '九级' when '10' then '十级'end) as LEVELS ,\n"); 
			sql.append("  (case bd.DISABILITY_GENUS_CODE when '1' then '因战' when '2' then '因公' when '2' then '因病'  end) as GENUS\n"); 
		}else if(type!=null&&"dependant".equals(type)){
			sql.append("   b.dependant_no as bpt_no\n"); 
		}else if(type!=null&&"war".equals(type)){
			sql.append("   b.war_no as bpt_no\n"); 
		}else if(type!=null&&"demobilized".equals(type)){
			sql.append("   b.demobilized_no as bpt_no\n"); 
		}else if(type!=null&&"retired".equals(type)){
			sql.append("   b.retired_no as bpt_no\n"); 
		}else if(type!=null&&"martyr".equals(type)){
			sql.append("   b.martyr_offspring_no as bpt_no\n"); 
		}
		
		
		if(type!=null&&"disability".equals(type)){
			sql.append("from baseinfo_people b , dic_city d  ,bpt_people_disability bd\n"); 
		}else {
			sql.append("from baseinfo_people b , dic_city d \n"); 
		}
		sql.append("   WHERE\n"); 
		sql.append("   substr(b.DOMICILE_CODE,0,6)||'000000'=d.id(+) and b.people_id=?");
		if(type!=null&&"disability".equals(type)){
			sql.append("  and bd.people_id= b.PEOPLE_ID");
		}
		DataSet ds = this.executeDataset(sql.toString(), new int[] { Types.VARCHAR},
			new Object[] { peopleId},true);
		
		if(ds.getCount()>0){
			Record r = ds.getRecord(0);
			String idCard = (String)r.get("ID_CARD");
			String bptNo = (String)r.get("BPT_NO");
			String domicileName = (String)r.get("FULL_NAME");
			String level = (String)r.get("LEVELS");
			String genus = (String)r.get("GENUS");
			str.append("身份证件号码:\n"+idCard);
			str.append("\n户籍地："+domicileName+"\n");
			str.append("证书编号:"+bptNo);
			if(type!=null&&"disability".equals(type)){
				str.append("\n伤残性质:"+genus);
				str.append("\n伤残等级:"+level);
			}
		}
		return str.toString();
	}
	/**
	 * 查询优抚对像基本信息列表新
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleInfo(ParameterSet pset) {
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		Set<String> set = pset.keySet();
		StringBuffer sql= new StringBuffer();
		String domicileCode = (String) pset.getParameter("domicileCode");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String objectState = (String) pset.getParameter("objectState");
		String objectType = (String) pset.getParameter("objectType");
		String organCode = (String) pset.getParameter("organCode");
		String bptNo = (String) pset.getParameter("bptNo");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String toTime = (String) pset.getParameter("toTime");
		String ageBegin = (String) pset.getParameter("ageBegin");
		String ageEnd = (String) pset.getParameter("ageEnd");
		String isprovinceMigrate = (String) pset.getParameter("isprovinceMigrate");
		String disabilityLevelCode = (String) pset.getParameter("disabilityLevelCode");
		String isExcel = (String) pset.getParameter("excel");
		String tistart="";
		String tiend="";
		String fobjectType="";
		if (objectType.contains(",")) {
			String ty[] = objectType.split(",");
			tistart = ty[0].substring(0, 1);// 获取第一个数的第一位
			tiend = ty[ty.length - 1].substring(0, 1);// 获取最后一个数的第一位
			fobjectType=ty[0];//将第一个值给objectType
			
		}else{
			fobjectType=objectType;
		}
		if(fobjectType==null||"".equals(fobjectType)||!tistart.equals(tiend)){//查询全部人员信息
			sql.append("SELECT A.*\n");
			sql.append("   FROM V_BPTPEOPLE_OBJECT_UNION A \n");
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sql.append("  ,bpt_province_migrate p\n"); //判定是否为迁移人员
			}
			sql.append("WHERE 1=1\n");
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sql.append("  and p.people_id = A.people_id \n");  //判定是否为迁移人员
			}
		}else {//分类查询
			sql.append("SELECT  \n");
			sql.append("A.ID_CARD, A.NAME, A.BIRTHDAY,NATION, A.SEX, A.RELATIONSHIP_TYPE, A.DOMICILE_TYPE,\n");
			sql.append("A.DOMICILE_CODE, A.DOMICILE_ADDRESS, A.APANAGE_CODE,A.ADDRESS, A.SAFEGUARD_TYPE,\n"); 
			sql.append("A.MEDICAL_CODE, A.PENSION_CODE, A.TEL_MOBILE, A.TEL_OTHER, A.POST_CODE, A.HEALTH_CODE,\n"); 
			sql.append("A.EDU_CODE, A.MARRIAGE_CODE,A.POLITICAL_CODE, A.EMPLOYMENT_CODE, A.INCOME_YEAR,\n"); 
			sql.append("A.WORK_UNIT_NAME,A.WORK_UNIT_CHARACTER, A.WORK_UNIT_TEL, A.WORK_UNIT_ADD, A.FAMILY_ID,\n"); 
			sql.append("A.PEOPLE_ID, A.DOMICILE_NAME, A.FULL_NAME,A.APANAGE_NAME,A.OBJECT_STATE, A.OBJECT_TYPE,\n"); 
			sql.append(" A.BPT_NO,A.APPROVE_DATE, A.OLD_LONELY_FLAG, A.ORPHAN_FLAG, A.WORK_ABILITY_CODE,A.HANDICAP_FLAG,\n"); 
			sql.append(" A.VIABILITY_CODE, A.SUPPORT_PATTERN,A.BANK, A.ACCOUNT_NAME,ACCOUNT_CODE, A.people_age,A.INSANITY_FLAG,");
			if("1".equals(fobjectType)&&tistart.equals(tiend)||"1".equals(objectType.substring(0, 1))){
				sql.append("D.CONSCRIPT_DATE,\n");
				sql.append("       D.DISABILITY_WAR_CODE,\n"); 
				sql.append("       D.IS_KOREA_WAR,\n"); 
				sql.append("       D.DISABILITY_GENUS_CODE,\n"); 
				sql.append("       D.DISABILITY_DATE,\n"); 
				sql.append("       D.VETERANS_DATE,\n"); 
				sql.append("       D.RETIRED_DATE,\n"); 
				sql.append("       D.UINIT_OF_DISABILITY,\n"); 
				sql.append("       D.DISABILITY_ADD,\n"); 
				sql.append("       D.DISABILITY_BODY,\n"); 
				sql.append("       D.DISABILITY_REASON,\n"); 
				sql.append("       D.DISABILITY_LEVEL_CODE,\n"); 
				sql.append("       D.DISABILITY_CASE_CODE\n"); 
				//sql.append("       D.disability_type_code");
			}else if("2".equals(fobjectType)&&tistart.equals(tiend)||"2".equals(objectType.substring(0, 1))){
				sql.append("D.STUDENT_FLAG,D.HOLDER_FLAG,  D.LEZSW_CERTIFICATE_ID,\n");
				sql.append("       D.LEZSW_NAME,D.LEZSW_SEX, D.LEZSW_BIRTHDAY, D.CONSCRIPT_DATE,\n"); 
				sql.append("       D.WORK_UNIT, D.POSITION, D.DEATH_DATE,\n"); 
				sql.append("       D.DEATH_ADDRESS, D.LEZSW_APPROVE_DATE, D.RELATIONSHIP");
			}else if("41".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("D.CONSCRIPT_DATE, D.DECRUITMENT_DATE,D.FORCES_NO,\n");
				sql.append("        D.POSITION,D.BELONGDATE,D.IS_KOREANWAR, D.ASDP_NO");
			}else if("42".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("D.CONSCRIPT_DATE, D.DECRUITMENT_DATE, D.FORCES_NO,\n");
				sql.append("      D.ASDP_NO,D.POSITION, D.IS_WAR,\n"); 
				sql.append("      D.IS_INNUCLEAR, D.PHYSICLAL_STATUS,\n"); 
				sql.append("      D.FAMILY_ECONOMICS, D.ILLESS_INFO,  D.HEALTH_STATE_CODE");
			}else if("5".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("D.CONSCRIPTC_DATE, D.DECRUITMENT_DATE, D.RETIRED_DATE,\n");
				sql.append("        D.ASDP_NO, D.FORCES_NO, D.POSITION,\n"); 
				sql.append("        D.WAR_TYPE_CODE, D.HEALTH_STATE_CODE, D.LIFE_STATE_CODE");
			}else if("6".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("D.CONSCRIPTC_DATE, D.DECRUITMENT_DATE, D.ASDP_NO,\n");
				sql.append("        D.FORCES_NO,  D.POSITION,D.TESTED_TYPE,\n"); 
				sql.append("        D.IS_HEALTH_FLAG,D.HEALTH_STATE_CODE, D.THIS_EXAMINATIONDATE,\n"); 
				sql.append("        D.THE_EXAMINATIONDATE, D.LIFE_STATE_CODE,\n"); 
				sql.append("        D.DISABILITY_LEVEL_CODE,D.DISABILITY_NUM, D.IDENTITY_BASIS");
			}else if("8".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("D.CONSCRIPT_DATE, D.DECRUITMENT_DATE, D.FORCES_NAME,\n");
				sql.append("        D.FORCES_NO,  D.SOLDIER_START_DATE, D.SOLDIER_END_DATE,\n"); 
				sql.append("        D.SOLDIER_YEARS, D.FAMILY_NUM,D.YOUNG_NUM,\n"); 
				sql.append("        D.OLD_NUM,D.IS_GUARANT,D.IS_FIVE_GUARANT, D.IDENTITY_BASIS");
			}else if("B".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("D.STATUS_TYPE,D.LEZSW_NAME, D.SACRIFICE_DATE,\n");
				sql.append("        D.LEZSW_APPROVE_DATE, D.RELATIONSHIP,  D.HOLDER_FLAG,\n"); 
				sql.append("        D.LIFE_STATE_CODE, D.GUARANT_FLAG, D.FIVE_GUARANT_FLAG,\n"); 
				sql.append("        D.ENJOYED_TREAT_FLAG");
			}
			sql.append(" FROM V_BPTPEOPLE_OBJECT_UNION A, ");

			if("1".equals(fobjectType)&&tistart.equals(tiend)||"1".equals(objectType.substring(0, 1))){
				sql.append("BPT_PEOPLE_DISABILITY D \n");
			}else if("2".equals(fobjectType)&&tistart.equals(tiend)||"2".equals(objectType.substring(0, 1))){
				sql.append("  BPT_PEOPLE_DEPENDANT D \n"); 
			}else if("41".equals(objectType)&&tistart.equals(tiend)){
				sql.append("  BPT_PEOPLE_DEMOBILIZED D \n");
			}else if("42".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("  BPT_PEOPLE_DEMOBILIZED_ILLNESS D \n"); 
			}else if("5".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("  BPT_PEOPLE_WAR D \n");
			}else if("6".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("  BPT_PEOPLE_TESTED D \n"); 
			}else if("8".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("  BPT_PEOPLE_RETIRED_SOLDIER D \n"); 
			}else if("B".equals(fobjectType)&&tistart.equals(tiend)){
				sql.append("  BPT_PEOPLE_MARTYR_OFFSPRING D ");
			}
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sql.append("  ,bpt_province_migrate p\n"); //判定是否为迁移人员
			}
			sql.append("WHERE A.PEOPLE_ID = D.PEOPLE_ID\n");
			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sql.append("  and p.people_id = A.people_id \n");  //判定是否为迁移人员
			}
		}
		
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			if (domicileCode != null && !domicileCode.equals("")) {
				if (!domicileCode.substring(0, 2).equals("00")
						&& domicileCode.substring(2, 4).equals("00")) {
					sql.append(" AND p.OUT_DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				} else if (!domicileCode.substring(2, 4).equals("00")
						&& domicileCode.substring(4).equals("00000000")) {
					sql.append(" AND p.OUT_DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				} else if (!domicileCode.substring(4, 6).equals("00")
						&& domicileCode.substring(6, 9).equals("000")) {
					sql.append(" AND p.OUT_DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				} else if (!domicileCode.substring(6, 9).equals("000")
						&& domicileCode.substring(9, 12).equals("000")) {
					sql.append(" AND p.OUT_DOMICILE_CODE like ?");// 街道
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				} else {
					sql.append(" AND p.OUT_DOMICILE_CODE = ?");// 社区
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			} else {
				if (!organCode.substring(0, 2).equals("00")
						&& organCode.substring(2, 4).equals("00")) {
					sql.append(" AND  p.OUT_DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				} else if (!organCode.substring(2, 4).equals("00")
						&& organCode.substring(4, 6).equals("00")) {
					sql.append(" AND p.OUT_DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4)+"%");
				} else {
					sql.append(" AND p.OUT_DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			} 
		}else {
		// domicileCode为暂时的，挂行政区划代码后，需写在上面
			if (domicileCode != null && !domicileCode.equals("")) {
				if (!domicileCode.substring(0, 2).equals("00")
						&& domicileCode.substring(2, 4).equals("00")) {
					sql.append(" AND A.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				} else if (!domicileCode.substring(2, 4).equals("00")
						&& domicileCode.substring(4).equals("00000000")) {
					sql.append(" AND A.DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				} else if (!domicileCode.substring(4, 6).equals("00")
						&& domicileCode.substring(6, 9).equals("000")) {
					sql.append(" AND A.DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				} else if (!domicileCode.substring(6, 9).equals("000")
						&& domicileCode.substring(9, 12).equals("000")) {
					sql.append(" AND A.DOMICILE_CODE like ?");// 街道
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				} else {
					sql.append(" AND A.DOMICILE_CODE=?");// 社区
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			} else {
				if (!organCode.substring(0, 2).equals("00")
						&& organCode.substring(2, 4).equals("00")) {
					sql.append(" AND A.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				} else if (!organCode.substring(2, 4).equals("00")
						&& organCode.substring(4, 6).equals("00")) {
					sql.append(" AND A.DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4)+"%");
				} else {
					sql.append(" AND A.DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			}
		}
		if (name != null && !name.equals("")) {
			sql.append(" AND A.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(name + "%");
		}

		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND A.ID_CARD LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard + "%");
		}

		if (bptNo != null && !bptNo.equals("")) {
			sql.append(" AND A.BPT_NO LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(bptNo + "%");
		}

		if (objectState != null && !objectState.equals("")) {
			sql.append(" AND A.OBJECT_STATE = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(objectState);
		}
		if (objectType != null && !objectType.equals("")) {
			/* 取出节点ID，并组合sql */
			String[] list = new String[20];
			list = objectType.split(",");
			sql.append(" AND (");
			for (int i = 0; i < list.length; i++) {
				sql.append(" A.OBJECT_TYPE like ?");
				typeList.add(Types.VARCHAR);
				argsList.add(list[i] + "%");
				if (i != list.length - 1) {
					sql.append(" OR ");
				} else {
					sql.append(" )");
				}
			}
		}
		if (disabilityLevelCode != null && !disabilityLevelCode.equals("")) {
			/* 取出节点ID，并组合sql */
			String[] list = new String[20];
			list = disabilityLevelCode.split(",");
			sql.append(" AND (");
			for (int i = 0; i < list.length; i++) {
				sql.append(" D.DISABILITY_LEVEL_CODE = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(list[i]);
				if (i != list.length - 1) {
					sql.append(" OR ");
				} else {
					sql.append(" )");
				}
			}
		}

		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" AND A.APPROVE_DATE BETWEEN ? AND ?\n");
			
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		if (toTime != null && !"".equals(toTime)) {
			sql.append(" AND A.APPROVE_DATE < ?\n");
			typeList.add(Types.VARCHAR);
			argsList.add(toTime);
		}
		if (ageBegin != null && !"".equals(ageBegin)) {
			sql.append(" AND A.PEOPLE_AGE >= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageBegin));
		}

		if (ageEnd != null && !"".equals(ageEnd)) {
			sql.append(" AND A.PEOPLE_AGE <= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageEnd));
		}
		for(String key:set){//变量查询条件 组织查询语句
			if(!"limit".equals(key)&&!"defaultSort".equals(key)
					&&!"dir".equals(key)&&!"start".equals(key)
					&&!"organCode".equals(key)&&!"startTime".equals(key)
					&&!"endTime".equals(key)&&!"bptNo".equals(key)
					&&!"objectType".equals(key)&&!"ageBegin".equals(key)
					&&!"ageEnd".equals(key)&&!"name".equals(key)
					&&!"idCard".equals(key)&&!"objectState".equals(key)
					&&!"isprovinceMigrate".equals(key)&&!"toTime".equals(key)
					&&!"domicileCode".equals(key)&&!"disabilityLevelCode".equals(key)){
				String value = (String)pset.get(key);
				if (value != null && !value.equals("")) {
					sql.append(" AND  ");
					sql.append(key);
					sql.append(" = ?");
					typeList.add(Types.VARCHAR);
					argsList.add(value);
				}
			}
			
		}

		DataSet ds = null;
		int[] types = null;
		Object[] args = null;
		if (typeList.size() != 0 && argsList.size() != 0) {
			types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			args = argsList.toArray(new Object[argsList.size()]);
		}
		// 判定是否是Excel执行的方法
		if ( !pset.containsKey("limit")) {// 导出Excel用的方法
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
	
	/**
	 * 查询60岁服兵役年限人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet querySoldierYear(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String year = (String) pset.getParameter("year");
		StringBuffer sql = new StringBuffer();


		sql.append("SELECT PEOPLE_ID, FAMILY_ID, DOMICILE_CODE, NAME, ID_CARD, SEX, \n");
		sql.append("           NATION, FULL_NAME AS DICNAME,v.OBJECT_TYPE \n"); 
		sql.append("    from v_bpt_object_union  v \n"); 
		sql.append("    where exists (select people_id from v_bpt_soldier_years p where v.PEOPLE_ID = p.PEOPLE_ID ");
		if(year != null && !"".equals(year)){
			if(">25".equals(year)){
				sql.append(" AND P.years>25" );
			}else{
				sql.append(" AND P.years=?" );
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
			
		}else {
			sql.append(" and p.years is not null ");
		}
		
		sql.append( ") and v.OBJECT_TYPE='81' AND V.OBJECT_STATE='2' and ");
		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" v.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2)+"%");
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" v.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4)+"%");
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" v.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6)+"%");
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" v.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9)+"%");
		} else { // 村
			sql.append(" v.domicile_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}



		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if (endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if (startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" AND TO_DATE(V.APPROVE_DATE, 'YYYY-MM-DD') BETWEEN TO_DATE(?, 'YYYY-MM-DD')\n");
			sql.append(" AND TO_DATE(?, 'YYYY-MM-DD') ");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		sql.append(" ORDER BY v.DOMICILE_CODE,v.NAME");

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
		} else {
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
						.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}
		}
		return ds;
	}
	
	/**
	 * 查询身份证号重复人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryRepeatIdcard(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		StringBuffer sql = new StringBuffer();

		sql.append("Select p.people_id, \n");
		sql.append("       p.family_id, \n"); 
		sql.append("       t.full_name, \n"); 
		sql.append("       p.id_card, \n"); 
		sql.append("       p.name, \n"); 
		sql.append("       p.sex, \n"); 
		sql.append("       p.disability_flag, \n"); 
		sql.append("       p.dependant_flag, \n"); 
		sql.append("       p.demobilized_flag, \n"); 
		sql.append("       p.war_flag, \n"); 
		sql.append("       p.retired_flag, \n"); 
		sql.append("       p.martyr_offspring_flag, \n"); 
		sql.append("	   b.demobilized_tyep_code, \n");
		sql.append("       b.war_type_code");
		sql.append("  From baseinfo_people p, dic_city t ,bpt_people b \n"); 
		sql.append(" Where p.domicile_code = t.id \n"); 
		sql.append("   and b.people_id=p.people_id");
		/*sql.append("   and not exists (select people_id \n"); 
		sql.append("          from baseinfo_people c \n"); 
		sql.append("         where c.disability_flag is null \n"); 
		sql.append("           and c.dependant_flag is null \n"); 
		sql.append("           and c.demobilized_flag is null \n"); 
		sql.append("           and c.war_flag is null \n"); 
		sql.append("           and c.retired_flag is null \n"); 
		sql.append("           and c.martyr_offspring_flag is null \n"); 
		sql.append("           and p.people_id = c.people_id) \n"); */
		sql.append("   and p.id_card In (Select s.id_card \n"); 
		sql.append("                       From baseinfo_people s \n"); 
		sql.append("                      Group By s.id_card \n"); 
		sql.append("                     Having Count(*) > 1) and \n"); 
		

		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append(" p.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2)+"%");
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append(" p.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4)+"%");
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append(" p.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6)+"%");
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append(" p.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9)+"%");
		} else { // 村
			sql.append(" p.domicile_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}



		if (name != null && !name.equals("")) {
			sql.append(" AND p.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(name + "%");
		}

		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND p.ID_CARD LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard + "%");
		}
		sql.append(" order by p.id_card");

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
		} else {
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
						.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}
		}
		return ds;
	}
	
	public void deletePeopele(ParameterSet pset){
		String peopleId = (String) pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
		sql.append("delete from baseinfo_people b where b.people_id='")
			.append(peopleId)
			.append("'");
		this.executeUpdate(sql.toString());
	}
	/**
	 * 查询双重身份人员
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDoubleIdentity(ParameterSet pset){
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		StringBuffer sql = new StringBuffer();

		sql.append("Select p.people_id, \n");
		sql.append("           p.family_id, \n"); 
		sql.append("           t.full_name as DOMICILE_NAME, \n"); 
		sql.append("           p.id_card, \n"); 
		sql.append("           p.name, \n"); 
		sql.append("           p.sex, \n"); 
		sql.append("         DECODE(p.disability_flag,1,p.disability_state_code) as disability_flag , \n"); 
		sql.append("           DECODE(p.dependant_flag,1,p.dependant_state_code) as dependant_flag, \n"); 
		sql.append("           DECODE(p.demobilized_flag,1,DECODE(b.demobilized_tyep_code,'41',p.demobilized_state_code)) as demobilized_flag, \n"); 
		sql.append("           DECODE(p.demobilized_flag,1,DECODE(b.demobilized_tyep_code,'42',p.demobilized_state_code)) as demobilizedill_flag, \n"); 
		sql.append("           DECODE(p.war_flag,1,DECODE(b.war_type_code,'51',p.war_state_code)) as war_flag, \n"); 
		sql.append("           DECODE(p.war_flag,1,DECODE(b.war_type_code,'61',p.war_state_code)) as test_flag, \n"); 
		sql.append("           DECODE(p.retired_flag,1,p.retired_state_code) as retired_flag, \n"); 
		sql.append("           DECODE(p.martyr_offspring_flag,1,p.martyr_offspring_state_code) as martyr_offspring_flag, \n"); 
		sql.append("         b.demobilized_tyep_code, \n"); 
		sql.append("           b.war_type_code \n"); 
		sql.append("      From baseinfo_people p, dic_city t ,bpt_people b \n"); 
		sql.append("     Where p.domicile_code = t.id \n"); 
		sql.append("       and b.people_id=p.people_id \n"); 
		sql.append(" and DECODE(p.disability_flag+p.disability_state_code,3,1,0)+ \n");
		sql.append("                   DECODE(p.dependant_flag+p.dependant_state_code,3,1,0)+ \n"); 
		sql.append("                  DECODE(p.demobilized_flag+p.demobilized_state_code,3,1,0)+ \n"); 
		sql.append("                   DECODE(p.war_flag+p.war_state_code,3,1,0)+ \n"); 
		sql.append("                   DECODE(p.retired_flag+p.retired_state_code,3,1,0)+ \n"); 
		sql.append("                   DECODE(p.martyr_offspring_flag+p.martyr_offspring_state_code,3,1,0)>1 ");


		if ("0000000000".equals(organCode.substring(2))) { // 省级
			sql.append("and p.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2)+"%");
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			sql.append("and p.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4)+"%");
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			sql.append("and p.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6)+"%");
		} else if ("000".equals(organCode.substring(9))) { // 街道
			sql.append("and p.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9)+"%");
		} else { // 村
			sql.append("and p.domicile_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}



		if (name != null && !name.equals("")) {
			sql.append(" AND p.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(name + "%");
		}

		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND p.ID_CARD LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard + "%");
		}
		sql.append(" order by p.id_card");

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), types, args, true);
			}
		} else {
			if(pset.containsKey("limit")) {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
						.getPageLimit(), true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}
		}
		return ds;
	}

		
}
