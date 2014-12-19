package com.inspur.cams.bpt.capital.excel.domain.support;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.capital.dao.IBptCapitalDetailDao;
import com.inspur.cams.bpt.capital.dao.IBptCapitalSummaryDao;
import com.inspur.cams.bpt.capital.dao.IBptCompulsoryDetailsDao;
import com.inspur.cams.bpt.capital.dao.IBptCompulsorySummaryDao;
import com.inspur.cams.bpt.capital.data.BptCapitalDetail;
import com.inspur.cams.bpt.capital.data.BptCapitalSummary;
import com.inspur.cams.bpt.capital.data.BptCompulsoryDetails;
import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;
import com.inspur.cams.bpt.capital.excel.dao.IImpExcelCapitalDao;
import com.inspur.cams.bpt.capital.excel.data.BptImpExcelCapitalTempMark;
import com.inspur.cams.bpt.capital.excel.domain.IImpExcelCapitalDomain;
import com.inspur.cams.bpt.excelToTable.data.ToTable;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 优抚资金发放excel导入domain接口实现类
 * 
 * @author zhanghui
 * 
 */
public class ImpExcepCapitalDomain implements IImpExcelCapitalDomain {

	@Reference
	private IImpExcelCapitalDao impExcelCapitalDao;

	@Reference
	private IBptCapitalSummaryDao bptCapitalSummaryDao;

	@Reference
	private IBptCapitalDetailDao bptCapitalDetailDao;
	
	@Reference
	private IBptCompulsorySummaryDao bptCompulsorySummaryDao;
	
	@Reference
	private IBptCompulsoryDetailsDao bptCompulsoryDetailsDao;

	/**
	 * 查询伤残验证信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDisabilityMark(ParameterSet pset) {
		return impExcelCapitalDao.query(pset);
	}

	/**
	 * 优抚资金发放excel导入临时表
	 * 
	 * @param excelData
	 * @param toTable
	 * @param pset
	 */
	public void importExcel(String[][] excelData, ToTable toTable,
			ParameterSet pset) {
		impExcelCapitalDao.importExcel(excelData, toTable, pset);
	}

	/**
	 * 资金发放伤残excel导入验证表表级验证
	 * 
	 * @param pset
	 */
	public void disablityValidate(ParameterSet pset) {
		impExcelCapitalDao.disablityValidate(pset);
	}

	/**
	 *  验证全部身份证号是否为该业务人员
	 * @param pset
	 */
	public void excelIdCardValidateAll(ParameterSet pset) {
		impExcelCapitalDao.excelIdCardValidateAll(pset);
	}
	
	/**
	 * 根据身份证查询该业务人员
	 * @param pset
	 * @return
	 */
	public DataSet excelIdCardValidate(ParameterSet pset) {
		return impExcelCapitalDao.excelIdCardValidate(pset);
	}

	/**
	 * 验证该时期内资金是否已发放
	 */
	public void excelIfGrant(String errorMessage, String viewName,
			ParameterSet pset) {
		impExcelCapitalDao.excelIfGrant(errorMessage, viewName, pset);
	}

	/**
	 * 验证该时期内资金是否已发放
	 */
	public void update(BptImpExcelCapitalTempMark bptImpExcelCapitalTempMark) {
		impExcelCapitalDao.update(bptImpExcelCapitalTempMark);
	}

	/**
	 * 验证某日期资金是否发放
	 * 
	 * @param pset
	 * @return
	 */
	public boolean ifGrant(ParameterSet pset) {
		return impExcelCapitalDao.ifGrant(pset);
	}

	/**
	 * 删除资金发放excel导入验证信息表记录
	 * 
	 * @param ids
	 */
	public void delete(String id) {
		impExcelCapitalDao.delete(id);
	}

	/**
	 * 验证该时期内资金是否已发放
	 */
	public DataSet excelIfGrant(ParameterSet pset) {
		return impExcelCapitalDao.excelIfGrant(pset);
	}

	/**
	 * 删除以id_card、register_type分组删除重复数据
	 */
	public void deleteRepeat() {
		impExcelCapitalDao.deleteRepeat();
	}

	/**
	 * 写入数据库
	 */
	public void saveCapital(ParameterSet pset) {
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		String organCode = (String) pset.getParameter("ORGAN_CODE");
		String registerType = (String) pset.getParameter("REGISTER_TYPE");
		pset.remove("startDate");
		pset.remove("endDate");

		String registerId = IdHelp.getUUID30();
		DataSet ds = null;
		
		if ("11".equals(registerType)) {
			ds = impExcelCapitalDao.queryDisability(pset);
		} else if ("21".equals(registerType)) {
			ds = impExcelCapitalDao.queryDependant(pset);
		} else if ("41".equals(registerType)) {
			ds = impExcelCapitalDao.queryDemobilized(pset);
		} else if ("42".equals(registerType)) {
			ds = impExcelCapitalDao.queryDemobilizedIll(pset);
		} else if ("51".equals(registerType)) {
			ds = impExcelCapitalDao.queryWarAndTested(pset);
		}
		
		if(ds != null) {
		
			String date = (String) ds.getRecord(0).get("GRANT_DATE");
	
			/** *********生成资金发放总表********************* */
			BptCapitalSummary bptCapitalSummary = new BptCapitalSummary();
	
			bptCapitalSummary.setRegisterId(registerId);
	
			bptCapitalSummary.setRegId(BspUtil.getEmpOrganId());
			bptCapitalSummary.setRegTime(DateUtil.getTime());
			bptCapitalSummary.setModId(BspUtil.getEmpOrganId());
			bptCapitalSummary.setModTime(DateUtil.getTime());
	
			bptCapitalSummary.setGrantFlag("1");
			bptCapitalSummary.setOrganCode(organCode);
			bptCapitalSummary.setRegisterType(registerType);
			bptCapitalSummary.setRegisterName(startDate + "至" + endDate + "发放名册");
	
			bptCapitalSummary.setGrantDate(date);
			bptCapitalSummary.setBuildDate(date);
			bptCapitalSummary.setGrantMonSum(new BigDecimal(impExcelCapitalDao
					.queryGrantMonSum(pset).getRecord(0).get("GRANT_MON_SUM")
					.toString()));
			bptCapitalSummary.setStartDate(startDate);
			bptCapitalSummary.setEndDate(endDate);
	
			bptCapitalSummaryDao.insert(bptCapitalSummary);
	
			String[] start = startDate.split("-");
			String[] end = endDate.split("-");
			int startYear = Integer.parseInt(start[0]);
			int startMonth = Integer.parseInt(start[1]);
			int endYear = Integer.parseInt(end[0]);
			int endMonth = Integer.parseInt(end[1]);
			int month = (endYear - startYear) * 12 + (endMonth - startMonth);
			month++; // 发放月数
	
			//批量保存发放明显
			List<BptCapitalDetail> lists = new ArrayList<BptCapitalDetail>();
			BptCapitalDetail bptCapitalDetail;
			Record record;
			for (int i = 0; i < ds.getCount(); i++) {
				record = ds.getRecord(i);
				bptCapitalDetail = new BptCapitalDetail();
				bptCapitalDetail.setState(1);
				bptCapitalDetail.setGrantMonths(new BigDecimal(month));
				bptCapitalDetail.setGrantStaMon(new BigDecimal(Double
						.parseDouble((String) record.get("GRANT_MON"))
						/ month));
	
				bptCapitalDetail.setRegisterId(registerId);
				bptCapitalDetail.setRegDetailId(IdHelp.getUUID30());
				bptCapitalDetail.setRegId(BspUtil.getEmpOrganId());
				bptCapitalDetail.setRegTime(DateUtil.getTime());
				bptCapitalDetail.setModId(BspUtil.getEmpOrganId());
				bptCapitalDetail.setModTime(DateUtil.getTime());
	
				bptCapitalDetail.setChangeState("2");
				bptCapitalDetail.setRegisterType(registerType);
	
				lists.add((BptCapitalDetail)getBptCapitalDetail(bptCapitalDetail, record));
			}
	
			bptCapitalDetailDao.save(lists);
	
			impExcelCapitalDao.delete(pset);
		}

	}

	/**
	 * 封装资金发放明细
	 * 
	 * @param bptCapitalDetail
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Object getBptCapitalDetail(
			Object bptCapitalDetail, Record record) {
		Iterator<String> iterator = (Iterator<String>) record.keys();
		String key;
		Object tempValue;
		Method[] methods = bptCapitalDetail.getClass().getDeclaredMethods();//获得类所有方法
		Method tempMethod = null;
		while (iterator.hasNext()) { //反射封装BptCapitalDetail对象
			tempMethod = null;
			key = iterator.next();
			for (Method method : methods) {
				if (mothedUtil(key).equals(method.getName())) {
					tempMethod = method;
					break;
				}
			}
			try {
				if (tempMethod != null) {
					Class classTypes = tempMethod.getParameterTypes()[0];
					if ("BigDecimal".equals(classTypes.getSimpleName())) {
						tempValue = record.get(key);
						if(tempValue != null) {
							tempMethod.invoke(bptCapitalDetail, new BigDecimal(
									tempValue.toString()));
						}
					} else {
						tempMethod.invoke(bptCapitalDetail, record.get(key));
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return bptCapitalDetail;
	}

	/**
	 * 转换PEOPLE_ID为setPeopleId格式
	 * @param str
	 * @return
	 */
	private String mothedUtil(String str) {
		str = str.toLowerCase();
		if (str.indexOf("_") != -1) {
			String[] strs = str.split("_");
			str = "set";
			for (int i = 0; i < strs.length; i++) {
				str += strs[i].replaceFirst(strs[i].substring(0, 1), strs[i]
						.substring(0, 1).toUpperCase());
			}
		} else {
			str = "set"
					+ str.replaceFirst(str.substring(0, 1), str.substring(0, 1)
							.toUpperCase());
		}
		return str;
	}
	
	
	/**
	 * 优待金写入数据库
	 * @param pset
	 */
	public void saveCompulsory(ParameterSet pset) {
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		String organCode = (String) pset.getParameter("ORGAN_CODE");
		pset.remove("startDate");
		pset.remove("endDate");

		String registerId = IdHelp.getUUID30();
		DataSet ds = impExcelCapitalDao.queryCompulsory(pset);
		
		if(ds != null) {
		
			String date = (String) ds.getRecord(0).get("GRANT_DATE");
	
			/** *********生成资金发放总表********************* */
			BptCompulsorySummary bptCompulsorySummary = new BptCompulsorySummary();
	
			bptCompulsorySummary.setRegisterId(registerId);
	
			bptCompulsorySummary.setRegId(BspUtil.getEmpOrganId());
			bptCompulsorySummary.setRegTime(DateUtil.getTime());
			bptCompulsorySummary.setModId(BspUtil.getEmpOrganId());
			bptCompulsorySummary.setModTime(DateUtil.getTime());
	
			bptCompulsorySummary.setGrantFlag("1");
			bptCompulsorySummary.setGrantUnit(organCode);
			bptCompulsorySummary.setRegisterName(startDate + "至" + endDate + "发放名册");
	
			bptCompulsorySummary.setGrantDate(date);
			bptCompulsorySummary.setGrantMon(new BigDecimal(impExcelCapitalDao
					.queryGrantMonSum(pset).getRecord(0).get("GRANT_MON_SUM")
					.toString()));
			bptCompulsorySummary.setStartDate(startDate);
			bptCompulsorySummary.setEndDate(endDate);
	
			bptCompulsorySummaryDao.insert(bptCompulsorySummary);
	
			String[] start = startDate.split("-");
			String[] end = endDate.split("-");
			int startYear = Integer.parseInt(start[0]);
			int startMonth = Integer.parseInt(start[1]);
			int endYear = Integer.parseInt(end[0]);
			int endMonth = Integer.parseInt(end[1]);
			int month = (endYear - startYear) * 12 + (endMonth - startMonth);
			month++; // 发放月数
	
			//批量保存发放明显
			List<BptCompulsoryDetails> lists = new ArrayList<BptCompulsoryDetails>();
			BptCompulsoryDetails bptCompulsoryDetails;
			Record record;
			for (int i = 0; i < ds.getCount(); i++) {
				record = ds.getRecord(i);
				bptCompulsoryDetails = new BptCompulsoryDetails();
				bptCompulsoryDetails.setState(1);
				bptCompulsoryDetails.setGrantMonths(new BigDecimal(month));
				bptCompulsoryDetails.setGrantMonSta(new BigDecimal(Double
						.parseDouble((String) record.get("GRANT_MON"))
						/ month));
	
				bptCompulsoryDetails.setRegisterId(registerId);
				bptCompulsoryDetails.setRegDetailId(IdHelp.getUUID30());
				bptCompulsoryDetails.setRegId(BspUtil.getEmpOrganId());
				bptCompulsoryDetails.setRegTime(DateUtil.getTime());
				bptCompulsoryDetails.setModId(BspUtil.getEmpOrganId());
				bptCompulsoryDetails.setModTime(DateUtil.getTime());
	
	
				lists.add((BptCompulsoryDetails)getBptCapitalDetail(bptCompulsoryDetails, record));
			}
	
			bptCompulsoryDetailsDao.save(lists);
	
			impExcelCapitalDao.delete(pset);
		}
	}

}
