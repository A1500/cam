package com.inspur.cams.drel.mbalance.cmd;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import javax.xml.namespace.QName;

import org.apache.axiom.om.OMAbstractFactory;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.OMFactory;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.loushang.demo.fact.Messages;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.ws.AxisFault;
import org.loushang.ws.addressing.EndpointReference;
import org.loushang.ws.client.Options;
import org.loushang.ws.rpc.client.RPCServiceClient;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoPeopleDao;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalConConfigDao;
import com.inspur.cams.drel.mbalance.domain.ISamMBalanceDomain;

/**
 * @title:SamMedicalBalanceQueryCommand
 * @description:一站式救助查询Command
 * @author:luguosui
 * @since:2011-05-13
 * @version:1.0
 */
@SuppressWarnings("unchecked")
public class SamMBalanceQueryCmd extends BaseQueryCommand {
	@Reference
	private ISamMBalanceDomain samMBalanceDomain = ScaComponentFactory
			.getService(ISamMBalanceDomain.class,
					"SamMBalanceDomain/SamMBalanceDomain");
	

	EntityDao<DicCity> extDao = (EntityDao<DicCity>) DaoFactory
			.getDao("com.inspur.cams.comm.extuser.dao.jdbc.ComExtOrganDao");

	EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
			.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");

	private Log logger = LogFactory.getLog(getClass());

	public void setSamMBalanceDomain(ISamMBalanceDomain samMBalanceDomain) {
		this.samMBalanceDomain = samMBalanceDomain;
	}

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet samMBalanceDS = samMBalanceDomain.query(pset);
		ArrayList<Record> list = new ArrayList<Record>();
		for (int i = 0; i < samMBalanceDS.getCount(); i++) {
			// 将金额数字格式化到小数点后两位
			Record samMBalanceRecord = samMBalanceDS.getRecord(i);
			samMBalanceRecord.set("totalExpense", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("totalExpense")
							.toString()));
			samMBalanceRecord.set("insuranceExpense", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("insuranceExpense")
							.toString()));
			samMBalanceRecord.set("insurancePay", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("insurancePay")
							.toString()));
			samMBalanceRecord.set("otherPay", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("otherPay")
							.toString()));
			samMBalanceRecord.set("assitancePay", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("assitancePay")
							.toString()));
			samMBalanceRecord.set("hospitalPay", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("hospitalPay")
							.toString()));
			samMBalanceRecord.set("specialPay", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("specialPay")
							.toString()));
			samMBalanceRecord.set("personalPay", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("personalPay")
							.toString()));
			samMBalanceRecord.set("illnessInsurancePay", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("illnessInsurancePay")
							.toString()));
			list.add(samMBalanceRecord);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(samMBalanceDS.getTotalCount());
		return ds;
	}

	/**
	 * 一站式结算救助对象信息查询
	 * 
	 * @return
	 */
	public DataSet queryPeople() {
		IBaseinfoPeopleDao dao = (IBaseinfoPeopleDao) DaoFactory.getDao(BaseinfoPeopleDao.class);
		ParameterSet paramSet = getParameterSet();
		return dao.queryForMBalance(paramSet);
	}

	/**
	 * 查询一站式结算信息
	 * 
	 * @return
	 */
	public DataSet queryForSamList() {
		ParameterSet paramSet = getParameterSet();
		DataSet samMBalanceDS = samMBalanceDomain.queryForSamList(paramSet);
		for (int i = 0; i < samMBalanceDS.getCount(); i++) {
			Record samMBalanceRecord = samMBalanceDS.getRecord(i);
			// 将金额数字格式化到小数点后两位
			samMBalanceRecord.set("TOTAL_EXPENSE", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("TOTAL_EXPENSE")
							.toString()));
			samMBalanceRecord.set("INSURANCE_EXPENSE", StrUtil
					.changeTwoDecimal(samMBalanceRecord
							.get("INSURANCE_EXPENSE").toString()));
			samMBalanceRecord.set("INSURANCE_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("INSURANCE_PAY")
							.toString()));
			samMBalanceRecord.set("OTHER_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("OTHER_PAY")
							.toString()));
			samMBalanceRecord.set("ASSITANCE_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("ASSITANCE_PAY")
							.toString()));
			samMBalanceRecord.set("HOSPITAL_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("HOSPITAL_PAY")
							.toString()));
			samMBalanceRecord.set("SPECIAL_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("SPECIAL_PAY")
							.toString()));
			samMBalanceRecord.set("PERSONAL_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("PERSONAL_PAY")
							.toString()));
		}
		return samMBalanceDS;
	}

	/**
	 * 一站式结算报表统计救助信息条数和救助总费用
	 * 
	 * @return
	 */
	public DataSet queryForSamBalanceReport() {
		ParameterSet paramSet = getParameterSet();
		return samMBalanceDomain.queryForReportDetail(paramSet);
	}

	/**
	 * 根据人员ID查询人员未出院人员信息，用于住院登记校验
	 * 
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForInCheck() {
		ParameterSet paramSet = getParameterSet();
		return samMBalanceDomain.queryForInCheck(paramSet);
	}

	/**
	 * 一站式结算报表统计
	 * 
	 * @return
	 */
	public DataSet queryForReport() {
		ParameterSet paramSet = getParameterSet();
		DataSet samMBalance = samMBalanceDomain.queryForReport(paramSet);
		String currentJsp = (String) paramSet.getParameter("currentJsp");
		if ("dom".equals(currentJsp)) {
			ArrayList<Record> list = new ArrayList<Record>();
			samMBalance.addField("domicileName");
			for (int i = 0; i < samMBalance.getCount(); i++) {
				Record familyRecord = samMBalance.getRecord(i);
				// 获取domicileName
				if (familyRecord.get("DOMICILE_CODE") != null) {
					String domicileCode = familyRecord.get("DOMICILE_CODE")
							.toString();
					paramSet.clear();
					paramSet.setParameter("ID", domicileCode);
					DataSet domicileCodeDS = dao.query(paramSet);
					if (domicileCodeDS.getCount() != 0) {
						Record domicileCodeRecord = domicileCodeDS.getRecord(0);
						String domicileName = domicileCodeRecord.get("name")
								.toString();
						familyRecord.set("domicileName", domicileName);
					} else {
						familyRecord.set("domicileName", " ");
					}

				}
				list.add(familyRecord);
			}
			DataSet ds = new DataSet();
			ds.getRecordSet().addAll(list);
			ds.setTotalCount(samMBalance.getTotalCount());
			return ds;
		} else if ("hos".equals(currentJsp)) {
			ArrayList list = new ArrayList();
			samMBalance.addField("hospitalName");
			for (int i = 0; i < samMBalance.getCount(); i++) {
				Record familyRecord = samMBalance.getRecord(i);
				// 获取domicileName
				if (familyRecord.get("HOSPITAL_ID") != null) {
					String hospictalId = familyRecord.get("HOSPITAL_ID")
							.toString();
					paramSet.clear();
					paramSet.setParameter("ORGAN_ID", hospictalId);
					DataSet domicileCodeDS = extDao.query(paramSet);
					if (domicileCodeDS.getCount() != 0) {
						Record domicileCodeRecord = domicileCodeDS.getRecord(0);
						String organName = domicileCodeRecord.get("organName")
								.toString();
						familyRecord.set("hospitalName", organName);
					} else {
						familyRecord.set("hospictalName", " ");
					}
				}
				list.add(familyRecord);
			}
			DataSet ds = new DataSet();
			ds.getRecordSet().addAll(list);
			ds.setTotalCount(samMBalance.getTotalCount());
			return ds;
		} else {
			return samMBalance;
		}
	}

	/**
	 * 一站式结算报表统计查询-按照医院，对象归属地，救助类型
	 * 
	 * @param paramSet
	 * @return
	 */
	public DataSet querybuilderList() {
		ParameterSet paramSet = getParameterSet();
		DataSet samMBalance = samMBalanceDomain.querybuilderList(paramSet);
		ArrayList<Record> list = new ArrayList<Record>();
		String bptType = " ";
		samMBalance.addField("hospitalName");
		samMBalance.addField("bptName");
		for (int i = 0; i < samMBalance.getCount(); i++) {
			Record samMBalanceRecord = samMBalance.getRecord(i);
			// 优抚类型解析
			bptType = getBptType(samMBalanceRecord);
			samMBalanceRecord.set("bptName", bptType);
			// 医院名称
			if (samMBalanceRecord.get("HOSPITAL_ID") != null) {
				String hospictalId = samMBalanceRecord.get("HOSPITAL_ID")
						.toString();
				paramSet.clear();
				paramSet.setParameter("ORGAN_ID", hospictalId);
				DataSet domicileCodeDS = extDao.query(paramSet);
				if (domicileCodeDS.getCount() != 0) {
					Record domicileCodeRecord = domicileCodeDS.getRecord(0);
					String organName = domicileCodeRecord.get("organName")
							.toString();
					samMBalanceRecord.set("hospitalName", organName);
				} else {
					samMBalanceRecord.set("hospitalName", " ");
				}
			}
			list.add(samMBalanceRecord);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(samMBalance.getTotalCount());
		return ds;
	}

	/**
	 * 明细查看
	 * 
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForDetailReport() {
		ParameterSet paramSet = getParameterSet();
		DataSet detailDataset = samMBalanceDomain.queryForDetailReport(paramSet);
		ArrayList list = new ArrayList();
		detailDataset.addField("bptName");
		String bptType = "";
		for (int i = 0; i < detailDataset.getCount(); i++) {
			Record samMBalanceRecord = detailDataset.getRecord(i);
			// 优抚类型解析
			bptType = getBptType(samMBalanceRecord);
			samMBalanceRecord.set("bptName", bptType);
			// 金额格式化
			samMBalanceRecord.set("TOTAL_EXPENSE", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("TOTAL_EXPENSE")
							.toString()));
			samMBalanceRecord.set("INSURANCE_EXPENSE", StrUtil
					.changeTwoDecimal(samMBalanceRecord
							.get("INSURANCE_EXPENSE").toString()));
			samMBalanceRecord.set("INSURANCE_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("INSURANCE_PAY")
							.toString()));
			samMBalanceRecord.set("OTHER_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("OTHER_PAY")
							.toString()));
			samMBalanceRecord.set("ASSITANCE_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("ASSITANCE_PAY")
							.toString()));
			samMBalanceRecord.set("HOSPITAL_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("HOSPITAL_PAY")
							.toString()));
			samMBalanceRecord.set("SPECIAL_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("SPECIAL_PAY")
							.toString()));
			samMBalanceRecord.set("PERSONAL_PAY", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("PERSONAL_PAY")
							.toString()));
			samMBalanceRecord.set("BPT_BASE", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("BPT_BASE")
							.toString()));
			samMBalanceRecord.set("INSURANCE_BASE", StrUtil
					.changeTwoDecimal(
							(samMBalanceRecord.get("INSURANCE_BASE")!=null?samMBalanceRecord.get("INSURANCE_BASE"):"0").toString()
					));
			samMBalanceRecord.set("ILLNESS_INSURANCE_PAY", StrUtil
					.changeTwoDecimal(
							(samMBalanceRecord.get("ILLNESS_INSURANCE_PAY")!=null?samMBalanceRecord.get("ILLNESS_INSURANCE_PAY"):"0").toString()	
							));
			list.add(samMBalanceRecord);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(detailDataset.getTotalCount());
		return ds;
	}

	/**
	 * 优抚查询（按医院、属地、优抚类别、时间段）
	 * 
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForBpt() {
		ParameterSet paramSet = getParameterSet();
		DataSet samMBalance = samMBalanceDomain.queryForBpt(paramSet);
		String currentJsp = (String) paramSet.getParameter("currentJsp");
		String bptType = "";
		if ("dom".equals(currentJsp)) {
			ArrayList list = new ArrayList();
			samMBalance.addField("domicileName");
			samMBalance.addField("bptName");
			for (int i = 0; i < samMBalance.getCount(); i++) {
				Record samMBalanceRecord = samMBalance.getRecord(i);
				// 获取domicileName
				if (samMBalanceRecord.get("DOMICILE_CODE") != null) {

					String domicileCode = samMBalanceRecord
							.get("DOMICILE_CODE").toString();

					paramSet.clear();
					paramSet.setParameter("ID", domicileCode);
					DataSet domicileCodeDS = dao.query(paramSet);
					if (domicileCodeDS.getCount() != 0) {
						Record domicileCodeRecord = domicileCodeDS.getRecord(0);
						String domicileName = domicileCodeRecord.get("name")
								.toString();
						samMBalanceRecord.set("domicileName", domicileName);
					} else {
						samMBalanceRecord.set("domicileName", " ");
					}
				}
				// 优抚类型解析
				bptType = getBptType(samMBalanceRecord);
				samMBalanceRecord.set("bptName", bptType);
				list.add(samMBalanceRecord);
			}
			DataSet ds = new DataSet();
			ds.getRecordSet().addAll(list);
			ds.setTotalCount(samMBalance.getTotalCount());
			return ds;
		} else if ("hos".equals(currentJsp)) {
			ArrayList list = new ArrayList();
			samMBalance.addField("hospitalName");
			samMBalance.addField("bptName");
			for (int i = 0; i < samMBalance.getCount(); i++) {
				Record samMBalanceRecord = samMBalance.getRecord(i);
				// 获取domicileName
				if (samMBalanceRecord.get("HOSPITAL_ID") != null) {

					String hospictalId = samMBalanceRecord.get("HOSPITAL_ID")
							.toString();

					paramSet.clear();
					paramSet.setParameter("ORGAN_ID", hospictalId);
					DataSet domicileCodeDS = extDao.query(paramSet);
					if (domicileCodeDS.getCount() != 0) {
						Record domicileCodeRecord = domicileCodeDS.getRecord(0);
						String organName = domicileCodeRecord.get("organName")
								.toString();
						samMBalanceRecord.set("hospitalName", organName);
					} else {
						samMBalanceRecord.set("hospictalName", " ");
					}
				}
				// 优抚类型解析
				bptType = getBptType(samMBalanceRecord);
				samMBalanceRecord.set("bptName", bptType);
				list.add(samMBalanceRecord);
			}
			DataSet ds = new DataSet();
			ds.getRecordSet().addAll(list);
			ds.setTotalCount(samMBalance.getTotalCount());
			return ds;
		} else {
			return samMBalance;
		}
	}

	/**
	 * 优抚明细查询（按医院、属地、优抚类别、时间段）
	 * 
	 * @param paramSet
	 * @return
	 */
	public DataSet queryYfDetail() {
		ParameterSet paramSet = getParameterSet();
		DataSet samMBalance = samMBalanceDomain.queryYfDetail(paramSet);
		String currentJsp = (String) paramSet.getParameter("currentJsp");
		if ("dom".equals(currentJsp)) {
			ArrayList list = new ArrayList();
			samMBalance.addField("domicileName");
			samMBalance.addField("bptName");
			for (int i = 0; i < samMBalance.getCount(); i++) {
				Record samMBalanceRecord = samMBalance.getRecord(i);
				// 获取domicileName
				if (samMBalanceRecord.get("DOMICILE_CODE") != null) {
					String domicileCode = samMBalanceRecord
							.get("DOMICILE_CODE").toString();
					paramSet.clear();
					paramSet.setParameter("ID", domicileCode);
					DataSet domicileCodeDS = dao.query(paramSet);
					if (domicileCodeDS.getCount() != 0) {
						Record domicileCodeRecord = domicileCodeDS.getRecord(0);
						String domicileName = domicileCodeRecord.get("name")
								.toString();
						samMBalanceRecord.set("domicileName", domicileName);
					} else {
						samMBalanceRecord.set("domicileName", " ");
					}
				}
				// 获取hospitalName
				if (samMBalanceRecord.get("HOSPITAL_ID") != null) {
					String hospictalId = samMBalanceRecord.get("HOSPITAL_ID")
							.toString();
					paramSet.clear();
					paramSet.setParameter("ORGAN_ID", hospictalId);
					DataSet domicileCodeDS = extDao.query(paramSet);
					if (domicileCodeDS.getCount() != 0) {
						Record domicileCodeRecord = domicileCodeDS.getRecord(0);
						String organName = domicileCodeRecord.get("organName")
								.toString();
						samMBalanceRecord.set("hospitalName", organName);
					} else {
						samMBalanceRecord.set("hospictalName", " ");
					}
				}
				String bptType = "";
				// 优抚类型解析
				bptType = getBptType(samMBalanceRecord);
				samMBalanceRecord.set("bptName", bptType);
				list.add(samMBalanceRecord);
			}
			DataSet ds = new DataSet();
			ds.getRecordSet().addAll(list);
			ds.setTotalCount(list.size());
			return ds;
		} else if ("hos".equals(currentJsp)) {
			ArrayList list = new ArrayList();
			samMBalance.addField("hospitalName");
			samMBalance.addField("bptName");
			for (int i = 0; i < samMBalance.getCount(); i++) {
				Record samMBalanceRecord = samMBalance.getRecord(i);
				// 获取hospitalName
				if (samMBalanceRecord.get("HOSPITAL_ID") != null) {

					String hospictalId = samMBalanceRecord.get("HOSPITAL_ID")
							.toString();

					paramSet.clear();
					paramSet.setParameter("ORGAN_ID", hospictalId);
					DataSet domicileCodeDS = extDao.query(paramSet);
					if (domicileCodeDS.getCount() != 0) {
						Record domicileCodeRecord = domicileCodeDS.getRecord(0);
						String organName = domicileCodeRecord.get("organName")
								.toString();
						samMBalanceRecord.set("hospitalName", organName);
					} else {
						samMBalanceRecord.set("hospictalName", " ");
					}
				}
				// 获取domicileName
				if (samMBalanceRecord.get("DOMICILE_CODE") != null) {
					String domicileCode = samMBalanceRecord
							.get("DOMICILE_CODE").toString();
					paramSet.clear();
					paramSet.setParameter("ID", domicileCode);
					DataSet domicileCodeDS = dao.query(paramSet);
					if (domicileCodeDS.getCount() != 0) {
						Record domicileCodeRecord = domicileCodeDS.getRecord(0);
						String domicileName = domicileCodeRecord.get("name")
								.toString();
						samMBalanceRecord.set("domicileName", domicileName);
					} else {
						samMBalanceRecord.set("domicileName", " ");
					}
				}
				String bptType = getBptType(samMBalanceRecord);
				samMBalanceRecord.set("bptName", bptType);
				list.add(samMBalanceRecord);
			}
			DataSet ds = new DataSet();
			ds.getRecordSet().addAll(list);
			ds.setTotalCount(list.size());
			return ds;
		} else {
			return samMBalance;
		}
	}

	/**
	 * 按救助对象属地、救助金额区间、时间段统计查询（柱状图展现）
	 * 
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForFlex() {
		ParameterSet paramSet = getParameterSet();
		DataSet samMBalance = samMBalanceDomain.queryForFlex(paramSet);
		ArrayList list = new ArrayList();
		samMBalance.addField("domicileName");
		for (int i = 0; i < samMBalance.getCount(); i++) {
			Record familyRecord = samMBalance.getRecord(i);
			// 获取domicileName
			if (familyRecord.get("DOMICILE_CODE") != null) {

				String domicileCode = familyRecord.get("DOMICILE_CODE")
						.toString();

				paramSet.clear();
				paramSet.setParameter("ID", domicileCode);
				DataSet domicileCodeDS = dao.query(paramSet);
				if (domicileCodeDS.getCount() != 0) {
					Record domicileCodeRecord = domicileCodeDS.getRecord(0);
					String domicileName = domicileCodeRecord.get("name")
							.toString();
					familyRecord.set("domicileName", domicileName);
				} else {
					familyRecord.set("domicileName", " ");
				}

			}
			list.add(familyRecord);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(samMBalance.getTotalCount());
		return ds;
	}

	/**
	 * 低保、五保救助对象中，重度残疾（1、2级伤残）、优抚对象、老年人数量和比例统计
	 * 
	 * @param paramSet
	 * @return
	 */
	public DataSet queryBptDisOld() {
		ParameterSet paramSet = getParameterSet();
		return samMBalanceDomain.queryBptDisOld(paramSet);
	}

	/**
	 * 解析优抚类型
	 * 
	 * @return
	 */
	public String getBptType(Record samMBalanceRecord) {
		String bptType = "";
		if ("1".equals(samMBalanceRecord.get("BPT_TYPE"))) {
			bptType = "伤残";
			if ("01".equals(samMBalanceRecord.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "一级" + bptType;
			} else if ("02".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "二级" + bptType;
			} else if ("03".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "三级" + bptType;
			} else if ("04".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "四级" + bptType;
			} else if ("05".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "五级" + bptType;
			} else if ("06".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "六级" + bptType;
			} else if ("07".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "七级" + bptType;
			} else if ("08".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "八级" + bptType;
			} else if ("09".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "九级" + bptType;
			} else if ("10".equals(samMBalanceRecord
					.get("DISABILITY_LEVEL_CODE"))) {
				bptType = "十级" + bptType;
			}
		} else if ("2".equals(samMBalanceRecord.get("BPT_TYPE"))) {
			bptType = "三属";
		} else if ("3".equals(samMBalanceRecord.get("BPT_TYPE"))) {
			bptType = "在乡复员军人";
		} else if ("4".equals(samMBalanceRecord.get("BPT_TYPE"))) {
			bptType = "带病回乡";
		} else if ("5".equals(samMBalanceRecord.get("BPT_TYPE"))) {
			bptType = "参战";
		}
		return bptType;
	}

	/**
	 * 对调用新农合接口产生的数据处理，将xml文件转换成Dataset
	 * 
	 * @author lgs
	 */
	public DataSet doInfoXML() {
		ParameterSet pset = getParameterSet();
		return samMBalanceDomain.getInsuranceDataSet(pset);

	}
	
	public DataSet queryForBalanceHistory() {
		ParameterSet pset = getParameterSet();
		return samMBalanceDomain.queryForBalanceHistory(pset);
	}
}
