package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.IMrmElectronicDao;
import com.inspur.cams.marry.base.data.MrmElectronic;

/**
 * 婚姻电子档案dao实现类
 * 
 */
public class MrmElectronicDao extends EntityDao<MrmElectronic> implements
		IMrmElectronicDao {

	@Override
	public Class<MrmElectronic> getEntityClass() {
		return MrmElectronic.class;
	}

	/**
	 * 通过sql查询下载列表
	 */
	public DataSet queryElectronic(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		String dutyId = (String) pset.getParameter("dutyId");
		String ids = (String) pset.getParameter("ids");
		StringBuffer sql = new StringBuffer("");
		if (dutyId != null && !("".equals(dutyId.trim()))) {
			sql
					.append("select e.* from mrm_duty_electronic de left join mrm_electronic e on e.electronic_id=de.electronic_id where 1=1");
			sql.append(" and de.duty_id=?");
			typeList.add(Types.VARCHAR);
			objsList.add(dutyId);
		} else if (ids != null && !("".equals(ids.trim()))) {
			sql.append("SELECT * FROM MRM_ELECTRONIC T WHERE 1=1 ");
			sql.append(" AND ( ");
			String[] ary = ids.split(";");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" ELECTRONIC_ID=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if (i != ary.length - 1) {
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}
		return ds;
	}

	/**
	 * 通过sql查询登记阶段法律要件信息
	 */
	public DataSet queryCatalogBySql(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		String applyType = (String) pset.getParameter("applyType");
		String deptId = (String) pset.getParameter("deptId");
		String applyId = (String) pset.getParameter("applyId");
		String upCatalogCode = (String) pset.getParameter("upCatalogCode");
		String catalogCode = (String) pset.getParameter("catalogCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT CATALOG_CODE,UP_CATALOG_CODE,APPLY_TYPE,FILE_CODE FROM MRM_CATALOG WHERE IF_VALID='1' AND CATALOG_LEVEL>1 ");
		if(upCatalogCode != null){
			sql.append(" AND UP_CATALOG_CODE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(upCatalogCode);
		}
		if(catalogCode!=null){
			sql.append(" AND CATALOG_CODE<>? ");
			typeList.add(Types.VARCHAR);
			objsList.add(catalogCode);
		}
		if (applyType != null && !("".equals(applyType.trim()))) {
			sql.append(" AND ( ");
			String[] ary = applyType.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" APPLY_TYPE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if (i != ary.length - 1) {
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		sql.append(" ORDER BY CATALOG_ORDER ASC ");
		DataSet catalogDS = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			catalogDS = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {
			catalogDS = this.executeDataset(sql.toString(),
					pset.getPageStart(), pset.getPageLimit(), true);
		}
		List<Record> list = catalogDS.getRecordSet();
		ArrayList<Record> records = new ArrayList<Record>();
		for (int i = 0; i < list.size(); i++) {
			Record map = (Record) list.get(i);
			MrmElectronic electronicBean = new MrmElectronic();
			electronicBean.setCatalogCode((String) map.get("CATALOG_CODE"));
			electronicBean.setApplyId(applyId);
			electronicBean.setApplyType((String) map.get("APPLY_TYPE"));
			electronicBean.setDeptId(deptId);
			electronicBean
					.setUpCatalogCode((String) map.get("UP_CATALOG_CODE"));
			electronicBean.setFileCode((String) map.get("FILE_CODE"));
			getInfo(electronicBean, null);
			Record record = new Record(electronicBean);
			records.add(record);
		}
		DataSet electronicDS = new DataSet();
		electronicDS.getRecordSet().addAll(records);
		electronicDS.setTotalCount(catalogDS.getTotalCount());
		return electronicDS;
	}




	/**
	 * 获取分号连接的上传文件名称、分号连接的上传文件ID、分号连接的上传文件描述
	 * 
	 * @param catalogCode
	 * @param deptId
	 * @param electronicBean
	 */
	public void getInfo(MrmElectronic electronicBean, String relatingCatalogCode) {
		String deptId = electronicBean.getDeptId();
		String applyId = electronicBean.getApplyId();
		StringBuffer fileNameBuf = new StringBuffer();
		StringBuffer electronicIdBuf = new StringBuffer();
		StringBuffer fileMessBuf = new StringBuffer();
		String catalogCode = null;
		if (relatingCatalogCode != null) {
			catalogCode = relatingCatalogCode;
		} else {
			catalogCode = electronicBean.getCatalogCode();
		}
		String str = new String();

		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer(
				"SELECT * FROM MRM_ELECTRONIC WHERE 1=1 ");
		if (deptId != null && !("".equals(deptId))) {
			sql.append(" AND DEPT_ID=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(deptId);
		}
		if (applyId != null && !("".equals(applyId))) {
			sql.append(" AND APPLY_ID=? ");
			typeList.add(Types.VARCHAR);
			if (applyId.split(";").length > 0) {
				objsList.add(applyId.split(";")[0]);
			} else {
				objsList.add(applyId);
			}

		}
		if (catalogCode != null && !("".equals(catalogCode))) {
			sql.append(" AND CATALOG_CODE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(catalogCode);
		}
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			list = this.executeQuery(sql.toString(), types, args);
		}
		if (list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				fileNameBuf.append((String) list.get(i).get("FILE_NAME"));
				fileNameBuf.append(";");
				electronicIdBuf.append((String) list.get(i)
						.get("ELECTRONIC_ID"));
				electronicIdBuf.append(";");
				if (list.get(i).get("FILE_MESS") == null) {
					fileMessBuf.append("无描述");
					fileMessBuf.append(";");
				} else {
					fileMessBuf.append((String) list.get(i).get("FILE_MESS"));
					fileMessBuf.append(";");
				}
			}
			str = fileNameBuf.toString();
			if (electronicBean.getFileName() == null) {
				electronicBean.setFileName(str.substring(0, str.length() - 1));
			} else {
				electronicBean.setFileName(str + electronicBean.getFileName());
			}
			str = electronicIdBuf.toString();
			if (electronicBean.getElectronicId() == null) {
				electronicBean.setElectronicId(str.substring(0,
						str.length() - 1));
			} else {
				electronicBean.setElectronicId(str
						+ electronicBean.getElectronicId());
			}
			str = fileMessBuf.toString();
			if (electronicBean.getFileMess() == null) {
				electronicBean.setFileMess(str.substring(0, str.length() - 1));
			} else {
				electronicBean.setFileMess(str + electronicBean.getFileMess());
			}
		}
	}


	/**
	 * 通过sql查询人员Electronic信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySql(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("");
		String deptId = (String) pset.getParameter("deptId");
		String applyId = (String) pset.getParameter("applyId");
		String applyType = (String) pset.getParameter("applyType");
		String catalogCode = (String) pset.getParameter("catalogCode");
		String electronicIds = (String) pset.getParameter("electronicIds");
			sql
					.append("SELECT E.ELECTRONIC_ID,E.APPLY_ID,E.FILE_CODE,E.DEPT_ID,E.APPLY_TYPE,E.IF_VALID,E.CATALOG_CODE,E.FILE_NAME,E.FILE_TYPE,E.FILE_MESS,E.FILE_PATH FROM MRM_ElECTRONIC E WHERE E.IF_VALID='1' ");
			if (deptId != null && !("".equals(deptId))) {
				sql.append(" AND E.DEPT_ID = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(deptId);
			}
			if (applyId != null && !("".equals(applyId))) {
				sql.append(" AND E.APPLY_ID = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(applyId);
			}
			if (applyType != null && !("".equals(applyType))) {
				sql.append(" AND E.APPLY_TYPE = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(applyType);
			}
			if (catalogCode != null && !("".equals(catalogCode))) {
				sql.append(" AND E.CATALOG_CODE = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(catalogCode);
			}
			if (electronicIds != null && !("".equals(electronicIds))) {
				String[] ary = electronicIds.split(";");
				sql
						.append(" UNION SELECT E.ELECTRONIC_ID,E.APPLY_ID,E.FILE_CODE,E.DEPT_ID,E.APPLY_TYPE,E.IF_VALID,E.CATALOG_CODE,E.FILE_NAME,E.FILE_TYPE,E.FILE_MESS,E.FILE_PATH FROM MRM_ElECTRONIC E WHERE E.IF_VALID='1' AND ( ");
				for (int i = 0; i < ary.length; i++) {
					sql.append(" E.ELECTRONIC_ID=? ");
					typeList.add(Types.VARCHAR);
					objsList.add(ary[i]);
					if (i != ary.length - 1) {
						sql.append(" OR ");
					}
				}
				sql.append(" ) ");
			}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}

	/**
	 * 根据applyId删除
	 */
	public void delByApplyId(String applyId) {
		if (applyId != null && !("".equals(applyId.trim()))) {
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM MRM_ELECTRONIC WHERE APPLY_ID = ? ");
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { applyId };
			executeUpdate(sql.toString(), types, args);
		}
	}

	/**
	 * 创建一条MRM_DUTY_ELECTRONIC信息
	 */
	public void insertMrmDutyElectronicBySql(String dutyId, String electronicId) {
		if (electronicId != null && !("".equals(electronicId.trim()))
				&& dutyId != null && !("".equals(dutyId))) {
			StringBuffer sql = new StringBuffer(
					"INSERT INTO MRM_DUTY_ELECTRONIC (ID,DUTY_ID,ELECTRONIC_ID) VALUES (?,?,?)");
			int[] types = new int[] { Types.VARCHAR, Types.VARCHAR,
					Types.VARCHAR };
			Object[] objs = new Object[] { IdHelp.getUUID32(), dutyId,
					electronicId };
			executeUpdate(sql.toString(), types, objs);
		}

	}

	/**
	 * 删除一条MRM_DUTY_ELECTRONIC信息
	 */
	public void deleteMrmDutyElectronicBySql(String dutyId, String electronicId) {
		if (electronicId != null && !("".equals(electronicId))
				&& dutyId != null && !("".equals(dutyId))) {
			StringBuffer sql = new StringBuffer(
					"DELETE FROM MRM_DUTY_ELECTRONIC WHERE DUTY_ID=? AND ELECTRONIC_ID=? ");
			int[] types = new int[] { Types.VARCHAR, Types.VARCHAR };
			Object[] args = new Object[] { dutyId, electronicId };
			executeUpdate(sql.toString(), types, args);
		}

	}

	/**
	 * 根据deptId查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicByDeptId(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer(
				"SELECT * FROM MRM_ELECTRONIC WHERE DEPT_ID=?  ");
		String deptId = (String) pset.getParameter("deptId");
		typeList.add(Types.VARCHAR);
		objsList.add(deptId);
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}

}
