package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.fis.base.dao.IFisCertCremationDao;
import com.inspur.cams.fis.base.data.FisCertCremation;
import com.inspur.cams.fis.util.BspUtil;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisCertCremationDao
 * @Description: TODO 殡葬业务火化证明表Dao的实现
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisCertCremationDao extends EntityDao<FisCertCremation> implements IFisCertCremationDao {

	public FisCertCremationDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCertCremation.class;
	}

	/**
	 * @Title: queryForCremationCretList
	 * @Description: TODO(火化证明列表查询方法)
	 * @param
	 * @param pset
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 */
	public DataSet queryForCremationCretList(ParameterSet pset) {

		String SReceiveTime = (String) pset.getParameter("SReceiveTime");
		String EReceiveTime = (String) pset.getParameter("EReceiveTime");
		String customIdCard = (String) pset.getParameter("customIdCard");
		String deadName = (String) pset.getParameter("deadName");
		String customName = (String) pset.getParameter("customName");
		String ifFeeEnd = (String) pset.getParameter("ifFeeEnd");
		String crametionStatus = (String) pset.getParameter("crametionStatus");

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();

		StringBuffer sql = new StringBuffer();
		sql.append("SELECT A.*,CC.CUSTOM_TYPE,CC.MOBIL_PHONE,CC.CUSTOM_NAME,CC.ID_CARD,D.NAME DEAD_NAME,D.SEX AS SEX,D.AGE AS AGE,");
		sql.append(" DECODE((SELECT COUNT(*) FROM FIS_CERT_CREMATION E WHERE E.DEAD_ID = D.DEAD_ID and  E.IF_ISSUE='1'), 0,'未打印','已打印') IFPRINT, SC.STATUS S_STATUS");
		sql.append(" FROM FIS_DEAD_INFO D  JOIN FIS_APPLY_INFO A ON D.DEAD_ID = A.DEAD_ID");
		sql.append(" JOIN (SELECT R.APPLY_ID,C.CUSTOM_ID,C.NAME AS CUSTOM_NAME,C.ID_CARD,C.MOBIL_PHONE,R.CUSTOM_TYPE FROM FIS_PERSONAL_CUSTOM C");
		sql.append(" LEFT JOIN FIS_PERSONAL_CUSTOM_ROLE R ON C.CUSTOM_ID = R.CUSTOM_ID WHERE R.CUSTOM_TYPE = '0'  ");
		if (StringUtils.isNotEmpty(customName)) {
			sql.append(" AND C.NAME=?");
			typeList.add(Types.VARCHAR);
			objsList.add(customName);
		}
		if (StringUtils.isNotEmpty(customIdCard)) {
			sql.append(" AND C.ID_CARD=?");
			typeList.add(Types.VARCHAR);
			objsList.add(customIdCard);
		}
		sql.append(" ) CC ON A.APPLY_ID = CC.APPLY_ID  ");
		sql.append(" JOIN FIS_SERVICE_CREMATION SC ON SC.DEAD_ID=D.DEAD_ID ");
		sql.append(" where 1=1 ");

		// 去掉已退费的火化服务
		sql.append(" AND SC.STATUS != ? ");
		typeList.add(Types.VARCHAR);
		objsList.add("3");

		if (StringUtils.isNotEmpty(deadName)) {
			sql.append(" AND D.NAME=?");
			typeList.add(Types.VARCHAR);
			objsList.add(deadName);
		}

		if (StringUtils.isNotEmpty(crametionStatus)) {
			sql.append(" AND SC.STATUS=?");
			typeList.add(Types.VARCHAR);
			objsList.add(crametionStatus);
		}
		if (StringUtils.isNotEmpty(SReceiveTime)) {
			sql.append(" AND A.RECEIVE_TIME>=?");
			typeList.add(Types.VARCHAR);
			objsList.add(SReceiveTime);
		}
		if (StringUtils.isNotEmpty(EReceiveTime)) {
			sql.append(" AND A.RECEIVE_TIME<=?");
			typeList.add(Types.VARCHAR);
			objsList.add(EReceiveTime);
		}
		if (StringUtils.isNotEmpty(ifFeeEnd)) {
			sql.append(" AND A.IF_FEE_END = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(ifFeeEnd);
		}
		sql.append(" ORDER BY A.APPLY_ID DESC ");// IFPRINT,
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}

	/**
	 * 
	 * @Title: queryCompleteHistory
	 * @Description: TODO(补办历史查询)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 */
	public DataSet queryCompleteHistory(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String deadId = (String) pset.getParameter("DEAD_ID");
		String customId = (String) pset.getParameter("CUSTOM_ID");

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();

		sql.append("SELECT D.NAME AS D_NAME,P.NAME AS P_NAME,P.RELATION,C.ISSUE_TIME,C.CREMATION_ID,C.NOTE,C.CERT_ID ");
		sql.append("  FROM FIS_DEAD_INFO D ");
		sql.append("  LEFT JOIN FIS_CERT_CREMATION C ON C.DEAD_ID = D.DEAD_ID ");
		sql.append("  LEFT JOIN FIS_PERSONAL_CUSTOM P ON D.DEAD_ID = P.DEAD_ID ");
		sql.append("WHERE C.IF_REISSUE = '1' and C.IF_ISSUE='1' ");
		if (StringUtils.isNotEmpty(deadId)) {
			sql.append(" AND D.DEAD_ID = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(deadId);
		}
		if (StringUtils.isNotEmpty(customId)) {
			sql.append(" AND P.CUSTOM_ID = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(customId);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}

	/**
	 * @Title: queryCremationCertBriefInfo
	 * @Description: TODO(火化证明概要信息)
	 * @return DataSet
	 * @param pset
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryCremationCertBriefInfo(ParameterSet pset) {
		DataSet ds = new DataSet();
		return ds;
	}

	/**
	 * @Title: printCremationCertAfter
	 * @Description: TODO(打印火化证明成功后操作) void
	 * @param pset
	 * @throws
	 * @author luguosui
	 */
	public void printCremationCertAfter(ParameterSet pset) {
		String certId = (String) pset.get("certId");
		String deadId = (String) pset.get("deadId");
		String applyId = (String) pset.get("applyId");
		String note = (String) pset.get("note");
		Record certCremationRec = (Record) pset.get("certCremationRec");
		String empOrganId = BspUtil.getEmpOrgan().getOrganId();
		String empOrganName = BspUtil.getEmpOrgan().getOrganName();
		String lastTimes = DateUtil.getTime();

		StringBuffer sql = new StringBuffer();

		if (certCremationRec != null) {
			ParameterSet psetInner = new ParameterSet();
			psetInner.setParameter("CERT_ID", certId);
			DataSet ds = query(psetInner);
			FisCertCremation fisCertCremation = (FisCertCremation) ds.getRecord(0).toBean(FisCertCremation.class);
			// 当前为补件：把本逝者其他证件均置为无效
			String sqlInner = "UPDATE FIS_CERT_CREMATION SET CERT_STATUS=?,CREATE_PEOPLE=?,CREATE_PEOPLE_NAME=?,CREATE_TIME=? WHERE DEAD_ID=? AND CERT_ID!=?";
			int[] typesInner = new int[6];
			Object[] argsInner = new Object[6];
			typesInner[0] = Types.VARCHAR;
			typesInner[1] = Types.VARCHAR;
			typesInner[2] = Types.VARCHAR;
			typesInner[3] = Types.VARCHAR;
			typesInner[4] = Types.VARCHAR;
			typesInner[5] = Types.VARCHAR;
			argsInner[0] = "0";
			argsInner[1] = empOrganId;
			argsInner[2] = empOrganName;
			argsInner[3] = lastTimes;
			argsInner[4] = deadId;
			argsInner[5] = fisCertCremation.getCertId();
			this.executeUpdate(sqlInner, typesInner, argsInner);
			// 冗余逝者信息
			fisCertCremation.setDeadId(deadId);
			fisCertCremation.setDeadName((String) certCremationRec.get("NAME"));
			fisCertCremation.setDeadSex((String) certCremationRec.get("SEX"));
			fisCertCremation.setDeadCardType((String) certCremationRec.get("CARD_TYPE"));
			fisCertCremation.setDeadAge((String) certCremationRec.get("AGE"));
			fisCertCremation.setDeadPopulace((String) certCremationRec.get("POPULACE"));
			fisCertCremation.setDeadIdCard((String) certCremationRec.get("ID_CARD"));
			fisCertCremation.setDeadDeathDate((String) certCremationRec.get("DEATH_DATE"));
			// 冗余火化记录相关信息
			fisCertCremation.setCremationId((String) certCremationRec.get("CREMATION_ID"));
			fisCertCremation.setCremationDate((String) certCremationRec.get("CREMATION_DATE"));
			// 冗余持证人信息
			// 其他标志
			fisCertCremation.setIfIssue("1");
			fisCertCremation.setIssuePeople(BspUtil.getEmpOrganId());
			fisCertCremation.setIssueTime(DateUtil.getTime());

			fisCertCremation.setCertStatus("1"); // 把本次设为有效

			fisCertCremation.setNote(note);
			fisCertCremation.setCreateTime(DateUtil.getDay());
			update(fisCertCremation);

		}

	}

	/**
	 * @Title: queryCremationCertMsg
	 * @Description: TODO(查询当前火化证明信息)
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryCremationCertMsg(ParameterSet pset) {
		String deadId = (String) pset.get("deadId");
		// 查询此逝者当前有效证书记录
		ParameterSet currPset = new ParameterSet();
		currPset.setParameter("CERT_STATUS", "1"); // 当前有效的数据
		currPset.setParameter("DEAD_ID", deadId);
		DataSet currCertDs = query(currPset);
		currPset.setParameter("CERT_STATUS", "0"); // 当前无效的数据
		currPset.setParameter("IF_ISSUE", "1"); // 未打印的数据
		DataSet hisCertDs = query(currPset);
		String noteCertIds = "";
		for (int i = 0; i < hisCertDs.getCount(); i++) {
			noteCertIds = noteCertIds + (String) hisCertDs.getRecord(i).get("certId");
			if (i + 1 < hisCertDs.getCount()) {
				noteCertIds = noteCertIds + "、";
			}
		}
		if (currCertDs.getCount() > 0 && StringUtils.isNotEmpty(noteCertIds)) {
			Record rec = currCertDs.getRecord(0);
			rec.set("BNote", "备注：编号为" + noteCertIds + "的火化证明作废，补发此证。");
			currCertDs.removeRecord(0);
			currCertDs.add(rec);
			currCertDs.setTotalCount(1);

		}
		return currCertDs;
	}

	/**
	 * @Title: queryCertInfoAndCustomInfo
	 * @Description: TODO(打印历史证明信息查询)
	 * @author wangziming
	 */
	public DataSet queryCertInfoAndCustomInfo(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String certId = (String) pset.getParameter("certId");

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();

		sql
				.append("SELECT C.CERT_ID,C.CANCEL_CERT_ID,C.DEAD_ID,C.DEAD_NAME,C.DEAD_SEX,C.DEAD_AGE,C.DEAD_CARD_TYPE,C.DEAD_ID_CARD,C.DEAD_POPULACE,C.CREMATION_DATE,P.NAME,O.SERVICE_PHONE ");
		sql.append("  FROM FIS_CERT_CREMATION C ");
		sql.append("  LEFT JOIN (SELECT PC.DEAD_ID, PC.NAME ");
		sql.append("               FROM FIS_PERSONAL_CUSTOM PC ");
		sql.append("               LEFT JOIN FIS_PERSONAL_CUSTOM_ROLE R ON PC.CUSTOM_ID = R.CUSTOM_ID ");
		sql.append("              WHERE R.CUSTOM_TYPE = '3') P ON P.DEAD_ID = C.DEAD_ID ");
		sql.append("  LEFT JOIN FIS_FUNERAL_ORGAN O ON O.ORGAN_ID = C.CREATE_ORGAN ");
		sql.append(" WHERE 1 = 1 ");
		if (StringUtils.isNotEmpty(certId)) {
			sql.append("   AND C.CERT_ID = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(certId);
		}

		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}

	public DataSet queryForExport(ParameterSet pSet) {
		String qStartTime = (String) pSet.get("qStartTime");
		String qEndTime = (String) pSet.get("qEndTime");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" SELECT * FROM FIS_CERT_CREMATION O ");
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