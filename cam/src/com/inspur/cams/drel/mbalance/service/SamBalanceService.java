package com.inspur.cams.drel.mbalance.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.dao.ISamMBalanceDao;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalDetailExpenseDao;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalPerDao;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalTopLineDao;
import com.inspur.cams.drel.mbalance.data.BalanceInfo;
import com.inspur.cams.drel.mbalance.data.BalancePreReturn;
import com.inspur.cams.drel.mbalance.data.CheckReturn;
import com.inspur.cams.drel.mbalance.data.ExpenseDetail;
import com.inspur.cams.drel.mbalance.data.HospitalRecord;
import com.inspur.cams.drel.mbalance.data.OperationReturn;
import com.inspur.cams.drel.mbalance.data.SamMBalance;
import com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense;
import com.inspur.cams.drel.mbalance.data.SamMedicalTopLine;

/**
 * 医疗救助一站式结算系统发布WebServices，供保险系统调用接口实现
 * 
 * @author 路国隋 2011-10-17
 */
public class SamBalanceService implements ISamBalanceService {

	@Reference
	private ISamMBalanceDao samMBalanceDao;
	@Reference
	private ISamMedicalPerDao samMedicalPerDao;
	@Reference
	private IBaseinfoPeopleDao baseinfoPeopleDao;
	@Reference
	private ISamMedicalDetailExpenseDao samMedicalDetailExpenseDao;
	@Reference
	private ISamMedicalTopLineDao samMedicalTopLineDao;

	private Log logger = LogFactory.getLog(getClass());

	/**
	 * 保存入院备案信息
	 * 
	 * @param hisRecord
	 *            入院备案信息对象
	 * @return 操作信息返回值
	 */
	public OperationReturn saveInRecord(HospitalRecord hosRecord) {
		SamMBalance dataBean = new SamMBalance();
		OperationReturn operationReturn = new OperationReturn();
		try {
			// 通过身份证号加载人员信息
			Map<String, Object> map = queryPeoInfo(hosRecord.getIdCard());
			if (map != null) {
				// 能查到此人信息
				if (StringUtils.isEmpty((String) map.get("assistanceType"))) {
					operationReturn.setReturnCode("01003");
					operationReturn.setReturnCodeDes("此人不属于低保五保不能备案！");
				} else {
					// 校验此人是否已住院未出院
					DataSet ds = samMBalanceDao.queryBalance("1", (String) map
							.get("peopleId"), hosRecord.getInDate(), hosRecord
							.getHospitalId(), "00");
					if (ds.getCount() > 0) {
						// 已住院未出院，不允许入院备案
						operationReturn.setReturnCode("01002");
						operationReturn.setReturnCodeDes("此人已住院未出院");
						return operationReturn;
					}
					dataBean.setAssitanceType((String) map
							.get("assistanceType"));
					dataBean.setSamCardNo((String) map.get("samCardNo"));
					dataBean.setDisabilityLevelCode((String) map
							.get("disabilityLevelCode"));
					dataBean.setBptCardNo((String) map.get("bptCardNo"));
					dataBean.setBptType((String) map.get("bptType"));
					dataBean.setFamilyId((String) map.get("familyId"));
					dataBean.setPeopleId((String) map.get("peopleId"));
					dataBean
							.setInsuranceType((String) map.get("insuranceType"));

					dataBean.setStatus("1");
					dataBean.setStrikeStatus("00");
					dataBean.setBalanceId(IdHelp.getUUID32());
					dataBean.setInDate(hosRecord.getInDate());
					dataBean.setHospitalDep(hosRecord.getDepartment());
					dataBean.setHospitalRecordId(hosRecord.getRecordNo());
					dataBean.setMedicalCode(hosRecord.getInsuranceNo());
					dataBean.setDiseaseCode(hosRecord.getDisease());
					dataBean.setDisease(hosRecord.getDiseaseName());
					dataBean.setHospitalId(hosRecord.getHospitalId());
					dataBean.setHospitalArea(hosRecord.getHospitalArea());
					dataBean.setHospitalName(hosRecord.getHospitalName());
					dataBean.setRegTime(DateUtil.getTime());
					dataBean.setDataSource("HIS");
					samMBalanceDao.insert(dataBean);
					operationReturn.setReturnCode("00000");
					operationReturn.setReturnCodeDes("保存成功");
					logger.debug("保存结束：" + System.currentTimeMillis());
				}
			} else {
				// 未查到此人信息
				operationReturn.setReturnCode("01001");
				operationReturn.setReturnCodeDes("未查到此人信息");

			}
		} catch (Exception e) {
			operationReturn.setReturnCode("0000X");
			operationReturn.setReturnCodeDes(e.getMessage());
			if (logger.isErrorEnabled()) {
				logger.error("未知异常！", e);
			}
		}
		logger.debug("保存结束" + operationReturn.getReturnCode() + ":"
				+ operationReturn.getReturnCodeDes());
		return operationReturn;
	}

	/**
	 * 保存出院结算信息或冲账信息
	 * 
	 * @param balanceInfo
	 *            出院结算信息对象 ；
	 * @return 操作信息返回值
	 */
	public OperationReturn balance(BalanceInfo balanceInfo) {
		OperationReturn operationReturn = new OperationReturn();

		SamMBalance dataBean = new SamMBalance();
		try {
			Map<String, Object> map = queryPeoInfo(balanceInfo.getIdCard());
			if (map != null) {
				if (balanceInfo.getTotalExpense().doubleValue() < 0) {
					// 冲账记录
					// 查询被冲记录
					DataSet ds = samMBalanceDao.queryBalance("2", (String) map
							.get("peopleId"), balanceInfo.getInDate(),
							balanceInfo.getHospitalId(), "00");
					if (ds.getCount() > 0) {
						// 能查到原纪录
						// 修改原纪录
						SamMBalance StrikeDataBean = (SamMBalance) ds
								.getRecord(0).toBean(SamMBalance.class);
						StrikeDataBean.setStrikeStatus("01");
						samMBalanceDao.update(StrikeDataBean);
						// 构建并保存冲账记录
						dataBean.setStrikeStatus("02");
						dataBean.setStatus("2");
						dataBean.setStrikeBalanceId((String) ds.getRecord(0)
								.get("BALANCE_ID"));
						dataBean.setBalanceId(IdHelp.getUUID32());
						dataBean.setPeopleId((String) map.get("peopleId"));
						dataBean.setFamilyId((String) map.get("familyId"));
						dataBean.setHospitalRecordId(balanceInfo.getRecordNo());
						dataBean.setHospitalDep(balanceInfo.getDepartment());
						dataBean.setHospitalName(balanceInfo.getHospitalName());
						dataBean.setBalanceTime(DateUtil.getDay());
						dataBean.setInDate(balanceInfo.getInDate());
						dataBean.setLeaveDate(balanceInfo.getLeaveDate());
						dataBean.setTotalExpense(balanceInfo.getTotalExpense()
								.doubleValue());
						dataBean.setInsuranceExpense(balanceInfo
								.getInsuranceExpense().doubleValue());
						dataBean.setInsurancePay(balanceInfo.getInsurancePay()
								.doubleValue());
						dataBean.setOtherPay(balanceInfo.getOtherPay()
								.doubleValue());

						dataBean.setAssitancePay(balanceInfo.getAssistancePay()
								.doubleValue());
						dataBean.setPersonalPay(balanceInfo.getPersonalPay()
								.doubleValue());
						dataBean.setInsuranceType((String) map
								.get("insuranceType"));
						dataBean.setMedicalCode(balanceInfo.getInsuranceNo());
						dataBean.setAssitanceType((String) map
								.get("assistanceType"));
						dataBean.setSamCardNo((String) map.get("samCardNo"));
						dataBean.setDisabilityLevelCode((String) map
								.get("disabilityLevelCode"));
						if (balanceInfo.getSpecialPay() != null) {
							dataBean.setSpecialPay(balanceInfo.getSpecialPay()
									.doubleValue());
						}
						if (balanceInfo.getHospitalPay() != null) {
							dataBean.setHospitalPay(balanceInfo
									.getHospitalPay().doubleValue());
						}
						if (balanceInfo.getSpecialPer() != null) {
							dataBean.setSpecialPer(balanceInfo.getSpecialPer()
									.doubleValue());
						}
						if (balanceInfo.getAssistancePer() != null) {
							if (balanceInfo.getAssistancePer().doubleValue() <= 1) {
								dataBean
										.setAssitancePer(balanceInfo
												.getAssistancePer()
												.doubleValue() * 100);
							}
						}
						dataBean.setBptCardNo((String) map.get("bptCardNo"));
						dataBean.setDisease(balanceInfo.getDiseaseName());
						dataBean.setDiseaseCode(balanceInfo.getDisease());
						dataBean.setHospitalId(balanceInfo.getHospitalId());
						dataBean.setHospitalArea(balanceInfo.getHospitalArea());
						dataBean.setRegTime(DateUtil.getTime());
						dataBean.setDataSource("HIS");
						samMBalanceDao.insert(dataBean);

						operationReturn.setReturnCode("00000");
						operationReturn.setReturnCodeDes("结算成功！");
					} else {
						// 不能查到原纪录
						operationReturn.setReturnCode("02002");
						operationReturn.setReturnCodeDes("在住院登备案信息未查到此人！");

					}
				} else {
					// 正常结算记录
					// 查询备案记录
					DataSet ds = samMBalanceDao.queryBalance("1", (String) map
							.get("peopleId"), balanceInfo.getInDate(),
							balanceInfo.getHospitalId(), "00");
					if (ds.getCount() > 0) {
						// 能查到原纪录
						dataBean.setBalanceId((String) ds.getRecord(0).get(
								"BALANCE_ID"));
						dataBean.setStrikeStatus("00");
						dataBean.setStatus("2");
						dataBean.setFamilyId((String) ds.getRecord(0).get(
								"FAMILY_ID"));
						dataBean.setPeopleId((String) ds.getRecord(0).get(
								"PEOPLE_ID"));
						dataBean.setRegTime((String) ds.getRecord(0).get(
								"REG_TIME"));

						dataBean.setHospitalRecordId(balanceInfo.getRecordNo());
						dataBean.setHospitalDep(balanceInfo.getDepartment());
						dataBean.setHospitalName(balanceInfo.getHospitalName());
						dataBean.setBalanceTime(DateUtil.getDay());
						dataBean.setInDate(balanceInfo.getInDate());
						dataBean.setLeaveDate(balanceInfo.getLeaveDate());
						dataBean.setTotalExpense(balanceInfo.getTotalExpense()
								.doubleValue());
						dataBean.setInsuranceExpense(balanceInfo
								.getInsuranceExpense().doubleValue());
						dataBean.setInsurancePay(balanceInfo.getInsurancePay()
								.doubleValue());
						dataBean.setOtherPay(balanceInfo.getOtherPay()
								.doubleValue());
						if (balanceInfo.getAssistancePer() != null) {
							if (balanceInfo.getAssistancePer().doubleValue() <= 1) {
								dataBean
										.setAssitancePer(balanceInfo
												.getAssistancePer()
												.doubleValue() * 100);
							}
						}
						if (balanceInfo.getSpecialPay() != null) {
							dataBean.setSpecialPay(balanceInfo.getSpecialPay()
									.doubleValue());
						}
						if (balanceInfo.getHospitalPay() != null) {
							dataBean.setHospitalPay(balanceInfo
									.getHospitalPay().doubleValue());
						}
						if (balanceInfo.getSpecialPer() != null) {
							dataBean.setSpecialPer(balanceInfo.getSpecialPer()
									.doubleValue());
						}
						dataBean.setAssitancePay(balanceInfo.getAssistancePay()
								.doubleValue());
						dataBean.setPersonalPay(balanceInfo.getPersonalPay()
								.doubleValue());
						dataBean.setInsuranceType((String) map
								.get("insuranceType"));
						dataBean.setMedicalCode(balanceInfo.getInsuranceNo());

						dataBean.setDisease(balanceInfo.getDiseaseName());
						dataBean.setDiseaseCode(balanceInfo.getDisease());
						dataBean.setHospitalId(balanceInfo.getHospitalId());
						dataBean.setHospitalArea(balanceInfo.getHospitalArea());

						dataBean.setInsuranceType((String) map
								.get("insuranceType"));
						dataBean.setMedicalCode(balanceInfo.getInsuranceNo());

						dataBean.setAssitanceType((String) map
								.get("assistanceType"));
						dataBean.setSamCardNo((String) map.get("samCardNo"));
						dataBean.setDataSource("HIS");
						samMBalanceDao.update(dataBean);

						operationReturn.setReturnCode("00000");
						operationReturn.setReturnCodeDes("结算成功！");

					} else {
						// 查看是否有冲账记录能查到记录
						DataSet balancedDs = samMBalanceDao.queryBalance("2",
								(String) map.get("peopleId"), balanceInfo
										.getInDate(), balanceInfo
										.getHospitalId(), "02");
						if (balancedDs.getCount() > 0) {
							dataBean.setBalanceId(IdHelp.getUUID32());
							dataBean.setStrikeStatus("00");
							dataBean.setStatus("2");
							dataBean.setFamilyId((String) balancedDs.getRecord(
									0).get("FAMILY_ID"));
							dataBean.setPeopleId((String) balancedDs.getRecord(
									0).get("PEOPLE_ID"));

							dataBean.setHospitalRecordId(balanceInfo
									.getRecordNo());
							dataBean
									.setHospitalDep(balanceInfo.getDepartment());
							dataBean.setHospitalName(balanceInfo
									.getHospitalName());
							dataBean.setBalanceTime(DateUtil.getDay());
							dataBean.setInDate(balanceInfo.getInDate());
							dataBean.setLeaveDate(balanceInfo.getLeaveDate());

							dataBean.setTotalExpense(balanceInfo
									.getTotalExpense().doubleValue());
							dataBean.setInsuranceExpense(balanceInfo
									.getInsuranceExpense().doubleValue());
							dataBean.setInsurancePay(balanceInfo
									.getInsurancePay().doubleValue());
							dataBean.setOtherPay(balanceInfo.getOtherPay()
									.doubleValue());
							if (balanceInfo.getSpecialPay() != null) {
								dataBean.setSpecialPay(balanceInfo
										.getSpecialPay().doubleValue());
							}
							if (balanceInfo.getHospitalPay() != null) {
								dataBean.setHospitalPay(balanceInfo
										.getHospitalPay().doubleValue());
							}
							if (balanceInfo.getSpecialPer() != null) {
								dataBean.setSpecialPer(balanceInfo
										.getSpecialPer().doubleValue());
							}
							if (balanceInfo.getAssistancePer() != null) {
								if (balanceInfo.getAssistancePer()
										.doubleValue() <= 1) {
									dataBean
											.setAssitancePer(balanceInfo
													.getAssistancePer()
													.doubleValue() * 100);
								}
							}
							dataBean.setAssitancePay(balanceInfo
									.getAssistancePay().doubleValue());
							dataBean.setPersonalPay(balanceInfo
									.getPersonalPay().doubleValue());
							dataBean.setInsuranceType((String) map
									.get("insuranceType"));
							dataBean.setMedicalCode(balanceInfo
									.getInsuranceNo());

							dataBean.setDisease(balanceInfo.getDiseaseName());
							dataBean.setDiseaseCode(balanceInfo.getDisease());
							dataBean.setHospitalId(balanceInfo.getHospitalId());
							dataBean.setHospitalArea(balanceInfo
									.getHospitalArea());

							dataBean.setInsuranceType((String) map
									.get("insuranceType"));
							dataBean.setMedicalCode(balanceInfo
									.getInsuranceNo());

							dataBean.setAssitanceType((String) map
									.get("assistanceType"));
							dataBean
									.setSamCardNo((String) map.get("samCardNo"));
							dataBean.setRegTime(DateUtil.getTime());
							dataBean.setDataSource("HIS");
							samMBalanceDao.insert(dataBean);

							operationReturn.setReturnCode("00000");
							operationReturn.setReturnCodeDes("结算成功！");
						} else {
							// 不能查到原纪录
							operationReturn.setReturnCode("02002");
							operationReturn.setReturnCodeDes("在住院登备案信息未查到此人！");

						}
					}
				}

			} else {
				operationReturn.setReturnCode("02001");
				operationReturn.setReturnCodeDes("未查到此人，此人不属于低保！！");
			}
		} catch (Exception e) {
			operationReturn.setReturnCode("0000X");
			operationReturn.setReturnCodeDes(e.getMessage());
			if (logger.isErrorEnabled()) {
				logger.error("未知异常！", e);
			}
		}
		return operationReturn;
	}

	/**
	 * 保存费用明细信息
	 * 
	 * @param detailArr
	 *            费用明细信息对象数组
	 * @return 操作信息返回值
	 */
	public OperationReturn saveExpenseDetail(ExpenseDetail[] detailArr) {
		OperationReturn operationReturn = new OperationReturn();
		List<SamMedicalDetailExpense> list = new ArrayList<SamMedicalDetailExpense>();
		String balanceId = "";
		if (detailArr.length > 0) {
			ParameterSet pset = new ParameterSet();
			pset.setParameter("ID_CARD", detailArr[0].getIdCard());
			DataSet ds = baseinfoPeopleDao.query(pset);
			if (ds.getCount() > 0) {
				// 能查到此人信息
				pset.clear();
				pset.setParameter("HOSPITAL_RECORD_ID", detailArr[0]
						.getRecordNo());
				pset
						.setParameter("MEDICAL_CODE", detailArr[0]
								.getInsuranceNo());
				pset.setParameter("PEOPLE_ID", ds.getRecord(0).get("peopleId"));
				pset.setParameter("STATUS", "2");
				pset.setParameter("STRIKE_STATUS", "00");
				pset.setParameter("sort", "REG_TIME");
				pset.setParameter("dir", "desc");
				DataSet samBalanceDS = samMBalanceDao.query(pset);
				if (samBalanceDS.getCount() > 0) {
					// 能查到住院备案信息
					balanceId = (String) samBalanceDS.getRecord(0).get(
							"balanceId");
					for (int i = 0; i < detailArr.length; i++) {
						SamMedicalDetailExpense dataBean = new SamMedicalDetailExpense();
						dataBean.setExpenseid(IdHelp.getUUID32());
						dataBean.setExpName(detailArr[i].getExpName());
						dataBean.setCode(detailArr[i].getExpCode());
						dataBean.setExpDate(detailArr[i].getExpDate());
						dataBean.setForm(detailArr[i].getForm());
						dataBean.setType(detailArr[i].getType());
						dataBean.setExpMoney(detailArr[i].getExpMoney());
						dataBean.setNum(detailArr[i].getNum());
						dataBean.setPrice(detailArr[i].getPrice());
						dataBean.setBalanceId(balanceId);

						list.add(dataBean);
					}
					samMedicalDetailExpenseDao.batchInsert(list);
					operationReturn.setReturnCode("00000");
					operationReturn.setReturnCodeDes("保存成功！");

				} else {
					// 查不到此人信息
					operationReturn.setReturnCode("03001");
					operationReturn.setReturnCodeDes("未查到此人信息！");

				}

			} else {
				// 查不到住院登记信息
				operationReturn.setReturnCode("03002");
				operationReturn.setReturnCodeDes("此人未住院");
			}
		}
		return operationReturn;

	}

	/**
	 * 根据入院备案信息核对入院人员是否具有低保五保身份
	 * 
	 * @param idCard
	 *            idCard 18位身份证号码
	 * @return 公民业务核查信息返回值
	 */
	public CheckReturn checkIdentity(String idCard) {
		Map peopleInfoMap = queryPeoInfo(idCard);

		CheckReturn dataBean = new CheckReturn();
		if (peopleInfoMap != null) {
			dataBean.setName((String) peopleInfoMap.get("name"));
			dataBean.setSex((String) peopleInfoMap.get("sex"));
			dataBean.setBirthday((String) peopleInfoMap.get("birthday"));
			dataBean.setIdCard((String) peopleInfoMap.get("idCard"));
			dataBean.setAssitanceType((String) peopleInfoMap
					.get("assistanceType"));
			dataBean.setSamCardNo((String) peopleInfoMap.get("samCardNo"));
			dataBean.setBptType((String) peopleInfoMap.get("bptType"));
			dataBean.setDisabilityLevel((String) peopleInfoMap
					.get("disabilityLevelCode"));
			dataBean
					.setDomicileCode((String) peopleInfoMap.get("domicileCode"));
			dataBean.setReturnCode("00000");
			dataBean.setReturnCodeDes("查询到相关人员信息");

			Map<String, Object> map = queryPeoInfo(idCard);
			// 获得封顶线
			BigDecimal hisAss = new BigDecimal(0.00);
			BigDecimal topLine = new BigDecimal(0.00);
			if (map != null) {
				// 获得封顶线
				topLine = queryBalanceTopLine((String) map.get("domicileCode"),
						(String) map.get("assistanceType"));
				ParameterSet hisPset = new ParameterSet();
				hisPset.setParameter("peopleId", (String) map.get("peopleId"));
				// 历史救助
				hisAss = (BigDecimal) (samMBalanceDao.queryForBalanceHistory(
						hisPset).getRecord(0).get("YEARASSISTANCE"));
				dataBean.setMaxPay(topLine.subtract(hisAss));
			}
		} else {
			// 此人不属于低保五保
			dataBean.setReturnCode("04001");
			dataBean.setReturnCodeDes("未查到此人，此人不属于低保五保");
		}
		return dataBean;
	}

	/**
	 * 查询结算准备信息
	 * 
	 * @param idCard
	 *            18位身份证号码
	 * @return 公民业务核查信息返回值
	 */
	public BalancePreReturn queryBalancePre(String idCard, String inDate) {
		// 获得个人信息
		Map<String, Object> map = queryPeoInfo(idCard);
		BalancePreReturn dataBean = new BalancePreReturn();
		try {
			// 获得封顶线
			BigDecimal hisAss = new BigDecimal(0.00);
			BigDecimal topLine = new BigDecimal(0.00);
			if (map != null) {
				// 能查到此人信息
				// 获得停助信息和救助类型
				DataSet ds = samMBalanceDao.queryBalance((String) map
						.get("peopleId"), inDate);
				if (ds.getCount() > 0) {
					// 办理过住院登记
					dataBean.setOtherPay((BigDecimal) ds.getRecord(0).get(
							"OTHER_PAY"));
					dataBean.setPauseFlag((String) ds.getRecord(0)
							.get("STATUS"));
					// 获得封顶线
					topLine = queryBalanceTopLine((String) map
							.get("domicileCode"), (String) map
							.get("assistanceType"));
					ParameterSet hisPset = new ParameterSet();
					hisPset.setParameter("peopleId", (String) map
							.get("peopleId"));
					// 历史救助
					hisAss = (BigDecimal) (samMBalanceDao
							.queryForBalanceHistory(hisPset).getRecord(0)
							.get("YEARASSISTANCE"));
					dataBean.setIdCard((String) map.get("idCard"));
					dataBean.setName((String) map.get("name"));
					dataBean.setMaxPay((topLine.subtract(hisAss)
							.subtract((dataBean.getOtherPay()))));
					dataBean.setReturnCode("00000");
					dataBean.setReturnCodeDes("正常信息返回！");
				} else {
					// 未办理住院登记
					dataBean.setReturnCode("05002");
					dataBean.setReturnCodeDes("在住院登备案信息未查到此人，未办理住院登记！");
				}
			} else {
				// 查不到此人信息
				dataBean.setReturnCode("05001");
				dataBean.setReturnCodeDes("未查到此人，此人不属于低保！");
			}
		} catch (Exception e) {
			dataBean.setReturnCode("0000X");
			dataBean.setReturnCodeDes(e.getMessage());
			if (logger.isErrorEnabled()) {
				logger.error("未知异常！", e);
			}
		}
		return dataBean;
	}

	/**
	 * 查询救助比例
	 * 
	 * @param domicileCode
	 *            救助对象属地行政区划
	 * @param payBase
	 *            救助基数
	 * @param assitanceType
	 *            救助对象类别
	 * @return 救助比例，string类型
	 */
	public String queryPercentage(String domicileCode, String payBase,
			String assistanceType, String inDate) {
		DataSet ds = samMedicalPerDao.queryPer(domicileCode, payBase,
				assistanceType);
		if (ds.getCount() > 0) {
			// 能查到救助比例
			BigDecimal per = ((BigDecimal) ds.getRecord(0).get("PERCENTAGE"))
					.divide(new BigDecimal(100));
			return per.toString();
		} else {
			// 查不到救助比例
			return "";
		}
	}

	public String queryBptPercentage(String domicileCode, String payBase,
			String bptType, String disabilityLevel, String inDate) {
		return "";
	}

	/**
	 * 查询封顶线
	 * 
	 * @param domicileCode
	 *            救助对象属地行政区划
	 * @param assitanceType
	 *            救助对象类别
	 * @return 救助封顶线，string类型
	 */
	private BigDecimal queryBalanceTopLine(String domicileCode,
			String assistanceType) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("YEAR", DateUtil.getYear());
		pset.setParameter("TYPE", assistanceType);
		pset.setParameter("DOMICILE_CODE", domicileCode.substring(0, 6)
				+ "000000");
		DataSet ds = samMedicalTopLineDao.query(pset);
		if (ds.getCount() > 0) {
			// 能查到救助封顶线
			SamMedicalTopLine bean = (SamMedicalTopLine) ds.getRecord(0)
					.toBean(SamMedicalTopLine.class);
			String topLine = bean.getTopLine();
			return new BigDecimal(topLine);
		} else {
			// 查不到救助封顶线
			return new BigDecimal(-1.00);
		}
	}

	/**
	 * 根据身份证号查询人员及家庭信息
	 */
	private Map<String, Object> queryPeoInfo(String idCard) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ID_CARD", idCard);
		DataSet ds = baseinfoPeopleDao.query(pset);
		Map<String, Object> map = new HashMap<String, Object>();

		// 伤残等级
		String disabilityLevelCode = "";
		// 优抚类别
		String bptType = "";
		// 优抚证号
		String bptCardNo = "";
		// 救助类别
		String assistanceType = "";
		// 低保五保证件号
		String samCardNo = "";

		if (ds.getCount() > 0) {
			// 能查到此人信息
			Record peoRecord = ds.getRecord(0);
			map.put("peopleId", peoRecord.get("peopleId"));
			map.put("name", peoRecord.get("name"));
			map.put("sex", peoRecord.get("sex"));
			map.put("birthday", peoRecord.get("birthday"));
			map.put("insuranceType", peoRecord.get("safeguardType"));
			map.put("idCard", peoRecord.get("idCard"));
			map.put("familyId", peoRecord.get("familyId"));
			map.put("domicileCode", peoRecord.get("domicileCode"));
			// 判断优抚类别
			if ("1".equals(peoRecord.get("disabilityFlag"))) {
				disabilityLevelCode = (String) peoRecord
						.get("disabilityLevelCode");
				bptType = "1";
				bptCardNo = (String) peoRecord.get("disabilityNo");
			} else if (("1".equals(peoRecord.get("dependantFlag")))
					|| ("1".equals(peoRecord.get("demobilizedFlag")))) {
				if ("1".equals(peoRecord.get("dependantFlag"))) {
					bptType = "2";
					bptCardNo = (String) peoRecord.get("dependantNo");
				}
				if ("1".equals(peoRecord.get("demobilizedFlag"))) {
					bptType = "3";
					bptCardNo = (String) peoRecord.get("demobilizedNo");
				}
			} else if ("0".equals(peoRecord.get("warFlag"))) {
				bptType = "4";
				bptCardNo = (String) peoRecord.get("warNo");
			}
			// 通过身份证号加载家庭救助基本信息
			DataSet familyAssDS = baseinfoPeopleDao.queryForInterface(idCard);
			// 该家庭是低保五保家庭
			for (int i = 0; i < familyAssDS.getCount(); i++) {
				Record assRecord = familyAssDS.getRecord(i);
				// 03代表受助类型为五保
				if ("03".equals(assRecord.get("ASSISTANCE_TYPE"))) {
					assistanceType = (String) assRecord.get("ASSISTANCE_TYPE");
					samCardNo = (String) assRecord.get("CARD_NO");
					break;
				} else if ("02".equals(assRecord.get("ASSISTANCE_TYPE"))
						|| "01".equals(assRecord.get("ASSISTANCE_TYPE"))) {
					assistanceType = (String) assRecord.get("ASSISTANCE_TYPE");
					samCardNo = (String) assRecord.get("CARD_NO");
					break;

				}
			}
			map.put("disabilityLevelCode", disabilityLevelCode);
			map.put("bptType", bptType);
			map.put("bptCardNo", bptCardNo);
			map.put("assistanceType", assistanceType);
			map.put("samCardNo", samCardNo);
			return map;
		} else {
			// 查不到此人信息
			return null;
		}

	}
}
