package com.inspur.cams.fis.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.FieldSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.fis.base.dao.IFisResourceInfoDao;
import com.inspur.cams.fis.base.data.FisResourceInfo;
import com.inspur.cams.fis.util.ProceduresUtil;
import com.inspur.cams.fis.util.ProceduresUtil.Proc;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisResourceInfoDao
 * @Description: TODO 殡葬业务资源表dao实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceInfoDao extends EntityDao<FisResourceInfo> implements IFisResourceInfoDao {

	public FisResourceInfoDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisResourceInfo.class;
	}

	/**
	 * @author mq
	 * @param pset
	 * @return
	 */
	public DataSet queryWithExtend(ParameterSet pset) {
		DataSet ds = new DataSet();
		String resourceId = (String) pset.getParameter("RESOURCE_ID");
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		sql
				.append("select i.*,e.record_id as extend_record_id,e.resource_kind,e.resource_area,e.resource_volume,e.note as extend_note from fis_resource_info i left join fis_resource_extend e on i.resource_id = e.resource_id where 1=1");
		if (resourceId != null && !("".equals(resourceId)) && !("undefined".equals(resourceId))) {
			sql.append(" and i.resource_id = ?");
			typeList.add(Types.VARCHAR);
			objList.add(resourceId);
		}
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
			// ds = RecordToBean.uppercaseToLowercase(ds);
		}
		return ds;
	}

	/**
	 * @author mq
	 * @param pset
	 * @return
	 */
	public DataSet queryWithPrice(ParameterSet pset) {
		DataSet ds = new DataSet();
		String resourceId = (String) pset.getParameter("RESOURCE_ID");
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		sql
				.append("select i.*,e.record_id as extend_record_id,e.resource_kind,e.resource_area,e.resource_volume,p.note as extend_note,p.use_year,p.price_standard,p.price,p.units,p.record_id as price_record_id from fis_resource_info i left join fis_resource_extend e on i.resource_id = e.resource_id  left join fis_price_resource p on i.resource_id = p.resource_id where 1=1");
		if (resourceId != null && !("".equals(resourceId)) && !("undefined".equals(resourceId))) {
			sql.append(" and i.resource_id = ?");
			typeList.add(Types.VARCHAR);
			objList.add(resourceId);
		}
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
			// ds = RecordToBean.uppercaseToLowercase(ds);
		}
		return ds;
	}

	/**
	 * 通过安葬申请表的墓穴位置 联合特征扩展表、墓价规则表查询
	 * 
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithPriceByBury(ParameterSet pset) {
		DataSet ds = new DataSet();
		String applyId = (String) pset.getParameter("applyId");
		if (StringUtils.isNotEmpty(applyId)) {
			StringBuffer sql = new StringBuffer();
			sql.append("select i.*," + "e.record_id as extend_record_id," + "e.resource_kind," + "e.resource_area," + "e.resource_volume," + "p.note as extend_note,"
					+ "p.use_year," + "p.price_standard," + "p.price," + "p.units," + "p.record_id as price_record_id " + "from fis_resource_info i "
					+ "left join fis_resource_extend e on i.resource_id = e.resource_id " + "left join fis_price_resource p on i.resource_id = p.resource_id " + "where 1 = 1 "
					+ "and i.resource_id = (select t.grave_id from fis_ceme_grave t where 1=1 and t.record_type='0' and t.if_cancel='0' and t.apply_id=?)");
			int[] types = new int[] { Types.VARCHAR };
			Object[] objs = new Object[] { applyId };
			ds = this.executeDataset(sql.toString(), types, objs, true);
			// ds = RecordToBean.uppercaseToLowercase(ds);
		}
		return ds;
	}

	// 查询服务所需资源，返回bean为大写表字段
	public DataSet queryForService(ParameterSet pset) {
		String serviceId = (String) pset.getParameter("serviceId");
		String resourceType = (String) pset.getParameter("resourceType");
		int[] type = new int[2];
		Object[] service = new Object[2];
		type[0] = Types.VARCHAR;
		service[0] = serviceId;
		type[1] = Types.VARCHAR;
		service[1] = resourceType;
		List list = this.executeQuery("SELECT * FROM FIS_RESOURCE_INFO R, FIS_SERVICE_RESOURCE S WHERE R.RESOURCE_ID = S.RESOURCE_ID AND S.SERVICE_ID = ? AND S.RESOURCE_TYPE = ?",
				type, service);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			FisResourceInfo fisResourceInfo = new FisResourceInfo();
			fisResourceInfo.setRelationId((String) map.get("RELATION_ID"));
			fisResourceInfo.setServiceId((String) map.get("SERVICE_ID"));
			fisResourceInfo.setResourceId((String) map.get("RESOURCE_ID"));
			fisResourceInfo.setResourceName((String) map.get("RESOURCE_NAME"));
			fisResourceInfo.setResourceFullName((String) map.get("RESOURCE_FULL_NAME"));
			fisResourceInfo.setResourceFormat((String) map.get("RESOURCE_FORMAT"));
			ds.addRecord(fisResourceInfo);
		}
		return ds;
	}

	/**
	 * 统计获取资源使用情况
	 */
	public DataSet queryForStatistics(ParameterSet pset) {
		String resourceType = (String) pset.getParameter("resourceType");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("select sum(DECODE(IN_USE,'1',1,0)) as USED,sum(DECODE(IN_USE,'0',1,0)) as NOT_USED from FIS_RESOURCE_INFO where 1=1");
		DataSet ds = new DataSet();
		if (resourceType != null && !("".endsWith(resourceType))) {
			sql.append(" and RESOURCE_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objList.add(resourceType);
		}
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			List list = this.executeQuery(sql.toString(), types, objs);
			if (list.size() == 1) {
				Map map = (Map) list.get(0);
				ds.addField("USED");
				ds.addField("NOT_USED");
				Record rd = new Record();
				rd.set("USED", (String) map.get("USED"));
				rd.set("NOT_USED", (String) map.get("NOT_USED"));
				ds.add(rd);
			}
		}
		return ds;
	}

	/**
	 * 查询停用墓穴对应的记录信息
	 * 
	 * @author mq
	 */
	public DataSet checkChildDisenableUse(ParameterSet pset) {
		String resourceId = (String) pset.getParameter("resourceId");
		DataSet ds = new DataSet();
		if (resourceId != null && !("".equals(resourceId))) {
			StringBuffer sql = new StringBuffer();
			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> objList = new ArrayList<Object>();
			sql
					.append("select pc.name, 'A' as state from fis_ceme_book_grave cbg,fis_personal_custom_role pcr,fis_personal_custom pc where cbg.apply_id = pcr.apply_id and cbg.apply_id = pc.apply_id and pcr.custom_type = '3'");
			sql.append(" and cbg.grave_place = ? ");
			typeList.add(Types.VARCHAR);
			objList.add(resourceId);
			sql.append(" union ");
			sql
					.append("select pc.name, 'B' as state from fis_ceme_grave cg,fis_personal_custom_role pcr,fis_personal_custom pc where cg.apply_id = pcr.apply_id and cg.apply_id = pc.apply_id and pcr.custom_type = '3'");
			sql.append(" and cg.grave_id = ? ");
			typeList.add(Types.VARCHAR);
			objList.add(resourceId);
			sql.append(" union ");
			sql.append("select di.name, 'C' as state from fis_ceme_bury cb, fis_dead_info di where cb.dead_id = di.dead_id");
			sql.append(" and cb.grave_place = ? ");
			typeList.add(Types.VARCHAR);
			objList.add(resourceId);
			if (typeList.size() > 0 && objList.size() > 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = typeList.get(i);
				}
				Object[] objs = objList.toArray(new Object[objList.size()]);
				ds = this.executeDataset(sql.toString(), types, objs, true);
			}
		}
		return ds;
	}

	/**
	 * 获取最低等级的最大个数（参数为上级ID的字符串组合(,)
	 */
	public BigDecimal getLastLevelMaxNum(ParameterSet pset) {
		String ids = (String) pset.getParameter("ids");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT MAX(SUB_NUM) AS SUB_NUM FROM (SELECT COUNT(*) AS SUB_NUM FROM FIS_RESOURCE_INFO T WHERE T.PARENT_RESOURCE IN (");

		String[] pids = ids.split(",");
		int[] types = new int[pids.length];
		Object[] args = new Object[pids.length];

		if (pids.length > 0) {
			for (int i = 0; i < pids.length; i++) {
				sql.append("?,");
				types[i] = Types.VARCHAR;
				args[i] = pids[i];
			}
			sql.deleteCharAt(sql.length() - 1);
			sql.append(") GROUP BY T.PARENT_RESOURCE) AA");
			List tempList = executeQuery(sql.toString(), types, args);
			if (tempList.size() > 0) {
				Map map = (Map) tempList.get(0);
				BigDecimal num = map.get("SUB_NUM") == null ? new BigDecimal("0") : (BigDecimal) map.get("SUB_NUM");
				return num;
			} else {
				return new BigDecimal("0");
			}
		}
		return new BigDecimal("0");
	}

	/**
	 * 修改资源状态
	 */
	public void changeResourceStatus(ParameterSet pset) {

	}

	/**
	 * @Title: beingLevelAndRule
	 * @Description: TODO(可分级的类别，是否定义级别和规则)
	 * @param
	 * @return void
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet beingLevelAndRule(ParameterSet pset) {
		String resourceType = (String) pset.get("resourceType");

		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("");
		sql.append("select frl.level_id from FIS_RESOURCE_LEVEL frl join FIS_RESOURCE_RULE frr on frl.level_id=frr.parent_level  where 1=1 ");
		if (StringUtils.isNotEmpty(resourceType)) {
			sql.append(" AND frl.resource_type = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(resourceType);
		}

		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}

	/**
	 * @Title: queryForMess
	 * @Description: TODO(查询格位的相关信息)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queryForMess(ParameterSet pset) {
		String parentResource = (String) pset.getParameter("parentResource");
		String resourceIds = (String) pset.getParameter("resourceId");
		String resourceType = (String) pset.getParameter("resourceType");
		String sort = (String) pset.getParameter("sort");
		String dir = (String) pset.getParameter("dir");

		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("");
		sql.append("  SELECT FRI.*,FDI.DEAD_ID, FDI.NAME ");
		sql.append("    FROM FIS_RESOURCE_INFO FRI ");
		sql.append("    LEFT JOIN FIS_SERVICE_CURRENT_EMPLACING FSE ON FSE.EMPLACING_PLACE =FRI.RESOURCE_ID  ");
		sql.append("    LEFT JOIN FIS_DEAD_INFO FDI ON FSE.DEAD_ID = FDI.DEAD_ID  ");
		sql.append("   WHERE 1 = 1 ");
		if (StringUtils.isNotEmpty(resourceType)) {
			sql.append(" AND FRI.RESOURCE_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(resourceType);
		}
		if (StringUtils.isNotEmpty(resourceIds)) {
			sql.append(" AND  (");
			String[] ary = resourceIds.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" FRI.RESOURCE_ID=? ");
				if (i != ary.length - 1) {
					sql.append(" OR ");
				}
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
			}
			sql.append(" ) ");
		}
		if (StringUtils.isNotEmpty(parentResource)) {
			sql.append(" AND  (");
			String[] ary = parentResource.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" FRI.PARENT_RESOURCE=? ");
				if (i != ary.length - 1) {
					sql.append(" OR ");
				}
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
			}
			sql.append(" ) ");
		}
		if (StringUtils.isNotEmpty(sort)) {
			sql.append(" ORDER BY ");
			sql.append(sort);
			sql.append("  ");
			if (StringUtils.isNotEmpty(dir)) {
				sql.append(dir);
			}
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		int num = ds.getCount();

		ArrayList<Record> arrRecList = new ArrayList<Record>();
		if (num > 0) {
			for (int i = 0; i < num; i++) {
				Record record = ds.getRecord(i);
				String resourceId = record.get("RESOURCE_ID") == null ? "" : (String) record.get("RESOURCE_ID");
				String deadId = record.get("DEAD_ID") == null ? "" : (String) record.get("DEAD_ID");
				String deadName = record.get("NAME") == null ? "" : (String) record.get("NAME");
				if (arrRecList.size() == 0) {
					arrRecList.add(record);
					continue;
				}
				int subSize = arrRecList.size();
				for (int j = 0; j < subSize; j++) {
					Record subRecord = arrRecList.get(j);
					String subResourceId = subRecord.get("RESOURCE_ID") == null ? "" : (String) subRecord.get("RESOURCE_ID");
					if (!subResourceId.equals(resourceId)) {
						if (j == subSize - 1) {
							arrRecList.add(record);
						}
						continue;
					} else {
						String subDeadId = subRecord.get("DEAD_ID") == null ? "" : (String) subRecord.get("DEAD_ID");
						String subDeadName = subRecord.get("NAME") == null ? "" : (String) subRecord.get("NAME");
						subDeadId = subDeadId + "*" + deadId;
						subDeadName = subDeadName + "*" + deadName;
						subRecord.set("DEAD_ID", subDeadId);
						subRecord.set("NAME", subDeadName);
						break;
					}
				}
			}
		}
		DataSet subDs = new DataSet();
		FieldSet fieldSet = ds.getFieldSet();

		subDs.getRecordSet().addAll(arrRecList);
		subDs.setTotalCount(arrRecList.size());
		subDs.setFieldSet(fieldSet);
		return subDs;
	}

	/**
	 * @Title: executeForCemeteryUsing
	 * @Description: TODO(墓穴使用情况统计)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet executeForCemeteryUsing(ParameterSet pset) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_RES_USED_STATISTIC");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "resource_type");
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String resourceType = (String) pset.getParameter("resourceType");
		map.put("parameterValue_1", resourceType);
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		int num = set.getCount();
		if (num > 0) {
			for (int i = 0; i < num; i++) {
				Record rec = set.getRecord(i);
				BigDecimal resourceUse = rec.get("RESOURCE_FORMAT") == null ? new BigDecimal(0) : new BigDecimal(rec.get("RESOURCE_FORMAT").toString());
				int resourceNum = resourceUse.intValue();
				String str = "穴";
				if (resourceNum == 0) {
					rec.set("RESOURCE_FORMAT", "");
				} else if (resourceNum == 1) {
					rec.set("RESOURCE_FORMAT", "单穴");
				} else if (resourceNum == 2) {
					rec.set("RESOURCE_FORMAT", "双穴");
				} else {
					rec.set("RESOURCE_FORMAT", resourceNum + str);
				}
			}
		}
		set = ProceduresUtil.fixDataSet(set);
		return set;
	}

	public String deleteFisResourceInfoWithExtend(ParameterSet pset) {
		String resourceId = (String) pset.getParameter("resourceId");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("");
		String msg = "";
		if (resourceId != null && !("".equals(resourceId))) {
			sql.append("select count(*) as num,'A' as state from fis_ceme_book_grave cbg where 1=1");
			sql.append(" and cbg.grave_place = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(resourceId);
			sql.append("union");
			sql.append("select count(*) as num,'B' as state from fis_ceme_grave cg where cg.record_type='0'");
			sql.append(" and cg.grave_id = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(resourceId);
			sql.append("union");
			sql.append("select count(*) as num,'C' as state from fis_ceme_bury cb where 1=1");
			sql.append(" and cb.grave_place = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(resourceId);
			sql.append("union");
			sql.append("select count(*) as num,'D' as state from fis_ceme_epitaph ce where ce.record_type='0'");
			sql.append(" and ce.grave_id = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(resourceId);
			if (typeList.size() > 0 && objsList.size() > 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = typeList.get(i);
				}
				Object[] args = objsList.toArray(new Object[objsList.size()]);
				DataSet ds = this.executeDataset(sql.toString(), types, args, true);
				for (int i = 0; i < ds.getCount(); i++) {
					Record record = ds.getRecord(i);
					if (record.get("STATE").equals("A")) {
						msg = msg + "留墓记录表有" + record.get("NUM") + "条记录;";
					}
					if (record.get("STATE").equals("B")) {
						msg = msg + "定墓记录表有" + record.get("NUM") + "条记录;";
					}
					if (record.get("STATE").equals("C")) {
						msg = msg + "安葬记录表有" + record.get("NUM") + "条记录;";
					}
					if (record.get("STATE").equals("D")) {
						msg = msg + "刻碑记录表有" + record.get("NUM") + "条记录;";
					}
				}
			}
		}
		return msg;
	}

	public DataSet queryForExport(ParameterSet pSet) {
		String qStartTime = (String) pSet.get("qStartTime");
		String qEndTime = (String) pSet.get("qEndTime");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" SELECT * FROM FIS_RESOURCE_INFO O ");
		if (StringUtils.isNotEmpty(qStartTime)) {
			sqlBuffer.append(" where O.CREATE_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qStartTime);
		}
		if (StringUtils.isNotEmpty(qEndTime)) {
			sqlBuffer.append(" and O.CREATE_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qEndTime);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sqlBuffer.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sqlBuffer.toString(), true);
		}
		return ds;
	}
}
