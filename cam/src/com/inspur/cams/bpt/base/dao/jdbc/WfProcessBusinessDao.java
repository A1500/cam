package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IWfProcessBusinessDao;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;

/**
 * @title:WfProcessBusinessDao
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
 */
public class WfProcessBusinessDao extends EntityDao<WfProcessBusiness>
		implements IWfProcessBusinessDao {

	public WfProcessBusinessDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<WfProcessBusiness> getEntityClass() {
		return WfProcessBusiness.class;
	}

	public DataSet queryById(String processId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PROCESS_ID", processId);
		return query(pset);
	}

	public static WfProcessBusinessDao getInstance() {
		return (WfProcessBusinessDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.WfProcessBusinessDao");
	}

	/**
	 * 根据assignmentId取得processId
	 */
	public String getProcessId(String assignmentId) {
		String sql = "SELECT PROCESS_ID FROM WF_END_TASK WHERE ID = ? ";
		return this.executeDataset(sql,new int[]{Types.VARCHAR},new Object[]{assignmentId}, true).getRecord(0).get("PROCESS_ID")
				.toString();
	}

	public String queryByProcessId(String processId) {
		String sql = "SELECT BUSINESS_ID FROM wf_process_business WHERE PROCESS_ID = ? ";
		return this.executeDataset(sql,new int[]{Types.VARCHAR},new Object[]{processId},true).getRecord(0).get("BUSINESS_ID")
				.toString();
	}

	/**
	 * 修改流程是否为退回
	 * 
	 * @param pset
	 */
	public void updateIfback(ParameterSet pset) {
		String applyId = (String) pset.getParameter("applyId");
		String ifback = (String) pset.getParameter("ifback");
		String sql = "UPDATE WF_PROCESS_BUSINESS SET IFBACK = ? WHERE BUSINESS_ID=?";
		this.executeUpdate(sql, new int[] { Types.VARCHAR, Types.VARCHAR },
				new Object[] { ifback, applyId });
	}

	/**
	 * 查询流程待办任务列表
	 * 
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryDaiBan(ParameterSet pset) {
		DataSet returnDs = new DataSet();
		List typeList = new ArrayList();
		List argsList = new ArrayList();
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT C.FULL_NAME, D.NAME SERVICE_NAME,B.NAME,B.ID_CARD,P.BUSINESS_TYPE AS SERVICE_TYPE, W.ID AS ASSIGNMENT_ID ,W.ORGAN_ID,W.ORGAN_NAME,");
		sql.append(" B.FAMILY_ID,P.BUSINESS_ID AS APPLY_ID,P.CONNECT_ID AS PEOPLE_ID,(CASE P.IFBACK WHEN 'Y' THEN '退回' WHEN 'N' THEN '正常' END) AS STATUS,");
		sql.append(" TO_CHAR(TO_DATE(SUBSTR(CREATE_TIME,1,8),'YYYY-MM-DD'),'YYYY-MM-DD') AS CREATE_TIME,W.ACTIVITY_ID,W.ACT_DEF_UNIQUE_ID,W.ACT_DEF_ID,W.ACT_DEF_NAME,");
		sql.append(" W.PRE_ACT_DEF_NAMES,W.PRE_ORGAN_NAMES,W.ACT_LIMIT_TIME,W.ACT_WARN_TIME,W.PROCESS_ID,W.PROC_DEF_UNIQUE_ID,");
		sql.append(" W.PROC_DEF_ID, W.PROC_DEF_NAME,TO_CHAR(TO_DATE(SUBSTR(PROC_CREATE_TIME,1,8),'YYYY-MM-DD'),'YYYY-MM-DD') AS PROC_CREATE_TIME,W.SUBJECT");
		sql.append(" FROM  WF_DAI_BAN_TASK W,WF_PROCESS_BUSINESS P,BASEINFO_PEOPLE B,DIC_BPT_SERVICE_TYPE D,DIC_CITY C");
		sql.append(" WHERE W.PROCESS_ID=P.PROCESS_ID AND P.CONNECT_ID=B.PEOPLE_ID AND P.BUSINESS_TYPE=D.CODE AND C.ID = B.DOMICILE_CODE");
		sql.append(" AND W.IS_VISIBLE='1'");

		/* 查询行政区划下的待办流程列表 */
		String[] organ_ids = (String[]) pset.get("organ_ids");
		/*
		 * String organ_id = ""; if (organ_ids != null) { int len =
		 * organ_ids.length; for (int i = 0; i < len; i++) { organ_id += "'" +
		 * organ_ids[i] + "'"; if (i != (len - 1)) { organ_id += ","; } } }
		 * 
		 * if (!"".equals(organ_id)) { sql.append(" and w.organ_id in(" +
		 * organ_id + ")"); }
		 */
		int len = organ_ids.length;
		for (int i = 0; i < len; i++) {
			if (i == 0) {
				sql.append(" AND ( W.ORGAN_ID =?");
			} else {
				sql.append(" OR W.ORGAN_ID =?");
				if (i == len - 1) {
					sql.append(" )");
				}
			}
			typeList.add(Types.VARCHAR);
			argsList.add(organ_ids[i]);
		}

		queryContion(sql, pset, typeList, argsList); // 拼接其他查询条件

		sql.append(" ORDER BY W.CREATE_TIME ");

		DataSet ds = null;
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}

		if (ds != null) {
			Record record = null;
			Record returnRecord;
			for (int i = 0; i < ds.getCount(); i++) {
				returnRecord = new Record();
				record = ds.getRecord(i);
				formatRecord(returnRecord, record);
				returnDs.add(returnRecord);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}

	/**
	 * 查询流程已办任务列表
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryYiBan(ParameterSet pset) {
		DataSet returnDs = new DataSet();
		List typeList = new ArrayList();
		List argsList = new ArrayList();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT C.FULL_NAME, B.PEOPLE_ID, B.FAMILY_ID, P.BUSINESS_ID AS APPLY_ID,\n");
		sql.append("       D.NAME AS SERVICE_NAME, B.NAME, B.ID_CARD,\n"); 
		sql.append("       P.BUSINESS_TYPE AS SERVICE_TYPE, W.ID AS ASSIGNMENT_ID, W.ORGAN_ID,\n"); 
		sql.append("       W.ORGAN_NAME, W.ACTIVITY_ID, W.ACT_DEF_UNIQUE_ID, W.ACT_DEF_ID,\n"); 
		sql.append("       W.ACT_DEF_NAME, W.PROCESS_ID, W.PROC_DEF_UNIQUE_ID, W.PROC_DEF_ID,\n"); 
		sql.append("       W.PROC_DEF_NAME, W.ACTIVE_ACT_DEF_NAMES, W.ACTIVE_ORGAN_NAMES,\n"); 
		sql.append("       W.SUBJECT,\n"); 
		sql.append("       TO_CHAR(TO_DATE(SUBSTR(W.END_TIME, 1, 8), 'yyyy-mm-dd'),\n"); 
		sql.append("                'yyyy-mm-dd') AS END_TIME,\n"); 
		sql.append("       TO_CHAR(TO_DATE(SUBSTR(W.PROC_CREATE_TIME, 1, 8), 'yyyy-mm-dd'),\n"); 
		sql.append("                'yyyy-mm-dd') AS PROC_CREATE_TIME\n"); 
		sql.append("  FROM WF_YI_BAN_TASK W, WF_PROCESS_BUSINESS P, BASEINFO_PEOPLE B,\n"); 
		sql.append("       DIC_BPT_SERVICE_TYPE D, DIC_CITY C,\n"); 
		sql.append("       (SELECT T.PRIMARY_KEY, MAX(T.END_TIME) END_TIME\n"); 
		sql.append("           FROM WF_YI_BAN_TASK T\n"); 
		sql.append("          WHERE T.ORGAN_ID = ?\n"); 
		sql.append("          GROUP BY T.PRIMARY_KEY) M\n"); 
		sql.append(" WHERE W.PROCESS_ID = P.PROCESS_ID AND P.CONNECT_ID = B.PEOPLE_ID AND\n"); 
		sql.append("       P.BUSINESS_TYPE = D.CODE AND C.ID = B.DOMICILE_CODE AND\n"); 
		sql.append("       W.END_TIME = M.END_TIME AND P.BUSINESS_ID = M.PRIMARY_KEY ");

		/* 查询行政区划下的已办流程列表 */
		String organ_id = (String) pset.get("organ_id");
		typeList.add(Types.VARCHAR);
		argsList.add(organ_id);
		if (!"".equals(organ_id)) {
			sql.append(" AND W.ORGAN_ID =?");
			typeList.add(Types.VARCHAR);
			argsList.add(organ_id);
		}

		queryContion(sql, pset, typeList, argsList); // 拼接其他查询条件

		sql.append(" ORDER BY W.END_TIME ");

		DataSet ds = null;
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}

		Record record = null;
		Record returnRecord;
		if (ds != null) {
			for (int i = 0; i < ds.getCount(); i++) {
				returnRecord = new Record();
				record = ds.getRecord(i);
				formatRecord(returnRecord, record);
				returnDs.add(returnRecord);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}

	/**
	 * 查询结束任务列表
	 * 
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryEndTask(ParameterSet pset) {
		int start = pset.getPageStart();
		int end = pset.getPageLimit();
		DataSet returnDs = new DataSet();
		List typeList = new ArrayList();
		List argsList = new ArrayList();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT C.FULL_NAME, B.PEOPLE_ID, B.FAMILY_ID, P.BUSINESS_ID AS APPLY_ID,\n");
		sql.append("       D.NAME AS SERVICE_NAME, B.NAME, B.ID_CARD,\n"); 
		sql.append("       P.BUSINESS_TYPE AS SERVICE_TYPE, W.ID AS ASSIGNMENT_ID, W.ORGAN_ID,\n"); 
		sql.append("       W.ORGAN_NAME, W.ACTIVITY_ID, W.ACT_DEF_UNIQUE_ID, W.ACT_DEF_ID,\n"); 
		sql.append("       W.ACT_DEF_NAME, W.PROCESS_ID, W.PROC_DEF_UNIQUE_ID, W.PROC_DEF_ID,\n"); 
		sql.append("       W.PROC_DEF_NAME, W.SUBJECT,\n"); 
		sql.append("       (CASE W.PROC_END_TIME\n"); 
		sql.append("          WHEN 'null' THEN ''\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           TO_CHAR(TO_DATE(SUBSTR(W.PROC_END_TIME, 1, 8), 'yyyy-mm-dd'), 'yyyy-mm-dd')\n"); 
		sql.append("        END) AS PROC_END_TIME,\n"); 
		
		sql.append("CASE    WHEN E.DISABILITY_TYPE_CODE !='00' THEN  DISABILITY_TYPE_CODE ");
		sql.append("        WHEN E.DEPENDANT_TYPE_CODE !='00' THEN DEPENDANT_TYPE_CODE  ");
		sql.append("        WHEN E.REDA_TYPE_CODE !='00' THEN REDA_TYPE_CODE  ");
		sql.append("        WHEN E.DEMOBILIZED_TYEP_CODE !='00' THEN DEMOBILIZED_TYEP_CODE ");
		sql.append("        WHEN E.WAR_TYPE_CODE !='00' THEN WAR_TYPE_CODE  ");
		sql.append("END     AS OBJECT_TYPE,");
		
		sql.append("       TO_CHAR(TO_DATE(SUBSTR(W.PROC_CREATE_TIME, 1, 8), 'yyyy-mm-dd'), 'yyyy-mm-dd') AS PROC_CREATE_TIME,\n"); 
		sql.append("       TO_CHAR(TO_DATE(SUBSTR(W.END_TIME, 1, 8), 'yyyy-mm-dd'), 'yyyy-mm-dd') AS END_TIME\n"); 
		sql.append("  FROM WF_END_TASK W, WF_PROCESS_BUSINESS P, BASEINFO_PEOPLE B, BPT_PEOPLE E,\n"); 
		sql.append("       DIC_BPT_SERVICE_TYPE D, DIC_CITY C,\n"); 
		sql.append("       (SELECT T.PRIMARY_KEY, MAX(T.END_TIME) END_TIME\n"); 
		sql.append("           FROM WF_END_TASK T\n"); 
		sql.append("          WHERE T.ORGAN_ID = ?\n"); 
		sql.append("          GROUP BY T.PRIMARY_KEY) M\n"); 
		sql.append(" WHERE W.PROCESS_ID = P.PROCESS_ID AND P.CONNECT_ID = B.PEOPLE_ID AND\n"); 
		sql.append("       P.BUSINESS_TYPE = D.CODE AND C.ID = B.DOMICILE_CODE AND E.PEOPLE_ID=B.PEOPLE_ID AND \n"); 
		sql.append("       W.END_TIME = M.END_TIME AND P.BUSINESS_ID = M.PRIMARY_KEY");

		/* 查询行政区划下的已办流程列表 */
		String organ_id = (String) pset.get("organ_id");
		
		typeList.add(Types.VARCHAR);
		argsList.add(organ_id);
		
		if (!"".equals(organ_id)) {
			sql.append(" AND W.ORGAN_ID =?");
			typeList.add(Types.VARCHAR);
			argsList.add(organ_id);
		}

		queryContion(sql, pset, typeList, argsList); // 拼接其他查询条件

		sql.append(" ORDER BY W.PROC_END_TIME ");

		DataSet ds = null;
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args,start,end,true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}

		Record record = null;
		Record returnRecord;
		if (ds != null) {
			for (int i = 0; i < ds.getCount(); i++) {
				returnRecord = new Record();
				record = ds.getRecord(i);
				formatRecord(returnRecord, record);
				returnDs.add(returnRecord);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}

	/**
	 * 流程监控（查询某人流程状态）
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryMonitor(ParameterSet pset) {
		DataSet returnDs = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM V_BPT_FLOW_QUERY B WHERE 1=1");

		String serviceType = (String) pset.get("serviceType");
		pset.remove("serviceType");
		queryContion(sql, pset, typeList, argsList); // 拼接其他查询条件

		if (!"".equals(serviceType) && serviceType != null) {
			if (serviceType.indexOf("#") != -1) {
				String[] serviceTypes = serviceType.split("#");
				for (int i = 0; i < serviceTypes.length; i++) {
					if (i == 0) {
						sql.append(" AND ( B.SERVICE_TYPE= ?");
					} else {
						sql.append(" OR  B.SERVICE_TYPE = ?");
						if (i == serviceTypes.length - 1) {
							sql.append(" )");
						}
					}
					typeList.add(Types.VARCHAR);
					argsList.add(serviceTypes[i]);
				}
			} else {
				sql.append(" AND  B.SERVICE_TYPE = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(serviceType);
			}
		}
		sql.append("  ORDER BY B.PROC_CREATE_TIME ");
		DataSet ds = null;
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}
		Record record = null;
		Record returnRecord;
		if (ds != null) {
			for (int i = 0; i < ds.getCount(); i++) {
				returnRecord = new Record();
				record = ds.getRecord(i);
				formatRecord(returnRecord, record);
				returnDs.add(returnRecord);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}

	/**
	 * 拼接查询条件
	 * 
	 * @param sql
	 * @param pset
	 * @param typeList
	 * @param argsList
	 */

	@SuppressWarnings("unchecked")
	private void queryContion(StringBuffer sql, ParameterSet pset,
			List typeList, List argsList) {

		/* 拼接行政区划查询条件 */
		if (pset.containsKey("domicode")) {
			String domicode = (String) pset.getParameter("domicode");
			if (domicode != null && !"".equals(domicode)) {
				if(!"00".equals(domicode.substring(2, 4))) { //非省级
					if ("00".equals(domicode.substring(4, 6))
							&& "00000000".equals(domicode.substring(4))) { // 市级
						sql.append(" AND B.DOMICILE_CODE like ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicode.substring(0, 4)+"%");
					} else if("000000".equals(domicode.substring(6))) { //县级
						sql.append(" AND B.DOMICILE_CODE like ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicode.substring(0, 6)+"%");
					} else if("000".equals(domicode.substring(9))) { //街道
						sql.append(" AND B.DOMICILE_CODE like  ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicode.substring(0, 9)+"%");
					} else { //村
						sql.append(" AND B.DOMICILE_CODE = ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicode);
					}
				} else { //省级
					sql.append(" AND B.DOMICILE_CODE like ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicode.substring(0, 2)+"%");
				}
			}
		}

		/* 拼接姓名查询条件 */
		if (pset.containsKey("name")) {
			String name = (String) pset.getParameter("name");
			if (!"".equals(name) && name != null) {
				sql.append(" AND B.NAME LIKE ?");
				typeList.add(Types.VARCHAR);
				argsList.add("%" + name + "%");
			}
		}

		/* 拼接身份证查询条件 */
		if (pset.containsKey("idCard")) {
			String idCard = (String) pset.getParameter("idCard");
			if (!"".equals(idCard) && idCard != null) {
				sql.append(" AND B.ID_CARD = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(idCard);
			}
		}

		/* 拼接业务类型查询条件 */
		if (pset.containsKey("serviceType")) {
			String serviceType = (String) pset.getParameter("serviceType");
			if (!"".equals(serviceType) && serviceType != null) {
				if (serviceType.indexOf("#") != -1) {
					// serviceType = serviceType.replaceAll("#", ",");
					String[] serviceTypes = serviceType.split("#");
					int len = serviceTypes.length;
					for (int i = 0; i < len; i++) {
						if (i == 0) {
							sql.append(" AND (P.BUSINESS_TYPE= ?");
						} else {
							sql.append(" OR P.BUSINESS_TYPE = ?");
							if (i == len - 1) {
								sql.append(" )");
							}
						}
						typeList.add(Types.VARCHAR);
						argsList.add(serviceTypes[i]);
					}
				} else {
					sql.append(" AND P.BUSINESS_TYPE = ?");
					typeList.add(Types.VARCHAR);
					argsList.add(serviceType);
				}
			}
		}
	}

	/**
	 * 格式化record，将record中PEOPLE_ID的值转换returnRecord中peopleId
	 * 
	 * @param returnRecord
	 * @param record
	 */
	@SuppressWarnings("unchecked")
	private void formatRecord(Record returnRecord, Record record) {
		Iterator<String> iterator = (Iterator<String>) record.keys();
		String key;
		while (iterator.hasNext()) {
			key = iterator.next();
			returnRecord.set(formatModelName(key), record.get(key));
		}
		iterator = null;
	}

	/**
	 * 转换列表名:如PEOPLE_ID转换为peopleId
	 * 
	 * @param str
	 * @return
	 */
	private String formatModelName(String str) {
		str = str.toLowerCase();
		if (str.indexOf("_") != -1) {
			String[] strs = str.split("_");
			str = strs[0];
			for (int i = 1; i < strs.length; i++) {
				str += strs[i].replaceFirst(strs[i].substring(0, 1), strs[i]
						.substring(0, 1).toUpperCase());
			}
		}
		return str;
	}
	
	/**
	 * 根据身份证号和业务类型查询流程状态
	 * 用于外网
	 * @param pset
	 * @return
	 */
	public DataSet queryWorkState(ParameterSet pset){
		String serviceType = (String) pset.get("serviceType");
		String idCard = (String) pset.get("idCard");
		DataSet returnDs = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		
		if("21".equals(serviceType)||"51".equals(serviceType)
				||"61".equals(serviceType)){

			sql.append("select C.FULL_NAME, \n");
			sql.append("       D.NAME AS SERVICE_NAME, \n"); 
			sql.append("       B.NAME, \n"); 
			sql.append("       B.ID_CARD, \n"); 
			sql.append("       e.service_type AS SERVICE_TYPE, \n"); 
			sql.append("       decode(e.commit_flag, '1', '已办结', '县级审批') as state \n"); 
			sql.append("  from baseinfo_people      b, \n"); 
			sql.append("       bpt_people           p, \n"); 
			sql.append("       DIC_CITY             C, \n"); 
			sql.append("       DIC_BPT_SERVICE_TYPE D, \n"); 
			sql.append("       bpt_apply_dependant  e, \n"); 
			sql.append("        (SELECT T.apply_id, MAX(T.Town_Aduit_Approve_Date) Town_Aduit_Approve_Date \n"); 
			sql.append("               FROM bpt_apply_dependant T \n"); 
			sql.append("              GROUP BY T.People_Id,t.apply_id) M \n"); 
			sql.append(" where b.people_id = p.people_id \n"); 
			sql.append("   and b.domicile_code = c.id \n"); 
			sql.append("   and e.people_id = b.people_id \n"); 
			sql.append("   and e.service_type = d.code \n"); 
			sql.append("   and e.apply_id=m.apply_id");
			sql.append(" AND  b.id_card= ?");
			sql.append(" AND  e.SERVICE_TYPE= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}if("81".equals(serviceType)
				||"B1".equals(serviceType)){
			sql.append("select C.FULL_NAME, \n");
			sql.append("       D.NAME AS SERVICE_NAME, \n"); 
			sql.append("       B.NAME, \n"); 
			sql.append("       B.ID_CARD, \n"); 
			sql.append("       e.service_type AS SERVICE_TYPE, \n"); 
			sql.append("       decode(e.commit_flag, '1', '已办结', '县级审批') as state \n"); 
			sql.append("  from baseinfo_people      b, \n"); 
			sql.append("       bpt_people           p, \n"); 
			sql.append("       DIC_CITY             C, \n"); 
			sql.append("       DIC_BPT_SERVICE_TYPE D, \n"); 
			sql.append("       BPT_APPLY_MARTYR_OFFSPRING  e, \n"); 
			sql.append("        (SELECT T.apply_id, MAX(T.AUDIT_DATE) AUDIT_DATE \n"); 
			sql.append("               FROM BPT_APPLY_MARTYR_OFFSPRING T \n"); 
			sql.append("              GROUP BY T.People_Id,t.apply_id) M \n"); 
			sql.append(" where b.people_id = p.people_id \n"); 
			sql.append("   and b.domicile_code = c.id \n"); 
			sql.append("   and e.people_id = b.people_id \n"); 
			sql.append("   and e.service_type = d.code \n"); 
			sql.append("   and e.apply_id=m.apply_id");
			sql.append(" AND  b.id_card= ?");
			sql.append(" AND  e.SERVICE_TYPE= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}else{
			sql.append("SELECT C.FULL_NAME, \n");
			sql.append("           D.NAME AS SERVICE_NAME, B.NAME, B.ID_CARD, \n"); 
			sql.append("           P.BUSINESS_TYPE AS SERVICE_TYPE, \n"); 
			sql.append("           (case  W.ACTIVE_ACT_DEF_NAMES when  '省级初审' then '省级审批' when '省级复审' then '省级审批' else W.ACTIVE_ACT_DEF_NAMES end)  as state \n"); 
			sql.append("      FROM WF_YI_BAN_TASK W, WF_PROCESS_BUSINESS P, BASEINFO_PEOPLE B, \n"); 
			sql.append("           DIC_BPT_SERVICE_TYPE D, DIC_CITY C, \n"); 
			sql.append("           (SELECT T.PRIMARY_KEY, MAX(T.END_TIME) END_TIME \n"); 
			sql.append("               FROM WF_YI_BAN_TASK T \n"); 
			sql.append("              GROUP BY T.PRIMARY_KEY) M \n"); 
			sql.append("     WHERE W.PROCESS_ID = P.PROCESS_ID AND P.CONNECT_ID = B.PEOPLE_ID AND \n"); 
			sql.append("           P.BUSINESS_TYPE = D.CODE AND C.ID = B.DOMICILE_CODE AND \n"); 
			sql.append("           W.END_TIME = M.END_TIME AND P.BUSINESS_ID = M.PRIMARY_KEY \n"); 
			sql.append(" AND  B.id_card= ?");
			sql.append(" AND  P.BUSINESS_TYPE= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
			sql.append("   union all \n"); 
			sql.append("   SELECT C.FULL_NAME, \n"); 
			sql.append("           D.NAME AS SERVICE_NAME, B.NAME, B.ID_CARD, \n"); 
			sql.append("           P.BUSINESS_TYPE AS SERVICE_TYPE, \n"); 
			sql.append("          '已办结'  as state \n"); 
			sql.append("      FROM WF_END_TASK W, WF_PROCESS_BUSINESS P, BASEINFO_PEOPLE B, BPT_PEOPLE E, \n"); 
			sql.append("           DIC_BPT_SERVICE_TYPE D, DIC_CITY C, \n"); 
			sql.append("           (SELECT T.PRIMARY_KEY, MAX(T.END_TIME) END_TIME \n"); 
			sql.append("               FROM WF_END_TASK T \n"); 
			sql.append("              GROUP BY T.PRIMARY_KEY) M \n"); 
			sql.append("     WHERE W.PROCESS_ID = P.PROCESS_ID AND P.CONNECT_ID = B.PEOPLE_ID AND \n"); 
			sql.append("           P.BUSINESS_TYPE = D.CODE AND C.ID = B.DOMICILE_CODE AND E.PEOPLE_ID=B.PEOPLE_ID AND \n"); 
			sql.append("           W.END_TIME = M.END_TIME AND P.BUSINESS_ID = M.PRIMARY_KEY \n"); 
			sql.append(" AND  B.id_card= ?");
			sql.append(" AND  P.BUSINESS_TYPE= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		
		DataSet ds = null;
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		return ds;
		
	}

}
