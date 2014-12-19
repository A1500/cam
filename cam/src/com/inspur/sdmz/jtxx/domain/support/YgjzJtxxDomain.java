package com.inspur.sdmz.jtxx.domain.support;


import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.dao.Column;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.Rule;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.sdmz.comFamilyOrgan.dao.ComFamilyOrgan;
import com.inspur.sdmz.comFamilyOrgan.dao.IComFamilyOrganDao;
import com.inspur.sdmz.jtxx.dao.ISamFamilyAssistanceDao;
import com.inspur.sdmz.jtxx.dao.ISamFamilyHouseDao;
import com.inspur.sdmz.jtxx.dao.IYgjzJtxxCyxxDao;
import com.inspur.sdmz.jtxx.dao.IYgjzJtxxDao;
import com.inspur.sdmz.jtxx.dao.IYgjzJtxxSzlxDao;
import com.inspur.sdmz.jtxx.dao.IYgjzJtxxZrzhDao;
import com.inspur.sdmz.jtxx.dao.IYgjzJzzsDao;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;
import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.data.SamPeopleEdu;
import com.inspur.sdmz.jtxx.data.SamPeopleAccident;
import com.inspur.sdmz.jtxx.data.BaseinfoFamily;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;
import com.inspur.sdmz.jtxx.data.SamFamilyAssistance;
import com.inspur.sdmz.jtxx.data.SamFamilyCalamity;
import com.inspur.sdmz.jtxx.data.SamIndex;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxDomain;
import com.inspur.sdmz.jzzs.dao.IYgjzJzzsConfDao;
import com.inspur.sdmz.jzzs.dao.IYgjzJzzsJzfsConfDao;
import com.inspur.sdmz.jzzs.data.YgjzJzzsConf;
import com.inspur.sdmz.jzzs.data.YgjzJzzsJzfsConf;

/**
 * @title:YgjzJtxxDomain
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
 */
public class YgjzJtxxDomain implements IYgjzJtxxDomain {

	private IYgjzJtxxDao ygjzjtxxDao;
	private IYgjzJzzsConfDao YgjzJzzsConfDao;
	private IYgjzJzzsJzfsConfDao ygjzJzzsJzfsConfDao;

	private IYgjzJtxxCyxxDao ygjzjtxxcyxxDao;
	private IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain;
	private IYgjzJtxxZrzhDao ygjzjtxxzrzhDao;
	private IYgjzJzzsDao ygjzjzzsDao;
	@Reference
	private ISamFamilyHouseDao samfamilyHouseDao;
	@Reference
	private IComFamilyOrganDao comfamilyOrganDao;
	@Reference
	private ISamFamilyAssistanceDao samFamilyAssistanceDao;
	
	@Reference
	public void setYgjzJtxxDao(IYgjzJtxxDao ygjzjtxxDao) {
		this.ygjzjtxxDao = ygjzjtxxDao;
	}

	@Reference
	public void setYgjzjtxxcyxxDao(IYgjzJtxxCyxxDao ygjzjtxxcyxxDao) {
		this.ygjzjtxxcyxxDao = ygjzjtxxcyxxDao;
	}

	@Reference
	public void setYgjzJzzsConfDao(IYgjzJzzsConfDao ygjzJzzsConfDao) {
		YgjzJzzsConfDao = ygjzJzzsConfDao;
	}

	@Reference
	public void setYgjzJzzsJzfsConfDao(IYgjzJzzsJzfsConfDao ygjzJzzsJzfsConfDao) {
		this.ygjzJzzsJzfsConfDao = ygjzJzzsJzfsConfDao;
	}

	public void saveYgjzJtxx(List<BaseinfoFamily> list) {
		this.ygjzjtxxDao.save(list);

		/*for (int i = 0; i < list.size(); i++) {
			BaseinfoFamily ygjzJtxx = list.get(i);
			countJtxxJzzs(ygjzJtxx);
		}*/
	}

	/**
	 * 更新上传委托协议时调用此方法
	 *
	 * @param list
	 */
	public void updateYgjzJtxx(List<BaseinfoFamily> list) {
		this.ygjzjtxxDao.batchUpdateWithFile(list);

		for (int i = 0; i < list.size(); i++) {
			BaseinfoFamily ygjzJtxx = list.get(i);
			countJtxxJzzs(ygjzJtxx);
		}
	}

	/**
	 * 计算并保存救助指数
	 * @param ygjzJtxx
	 */
	public void countJtxxJzzs(String familyId) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("FAMILY_ID", familyId);
		List<BaseinfoFamily> list = ygjzjtxxDao.queryNoPage(map);
		if (list.size() > 0) {
			countJtxxJzzs(list.get(0));
		}
	}
	/**
	 * 计算并保存救助指数
	 * @param ygjzJtxx
	 */
	public void countJtxxJzzs(BaseinfoFamily ygjzJtxx) {
		String familyId = ygjzJtxx.getFamilyId();

		// 查询人员信息类表
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("FAMILY_ID", familyId);
		List<BaseinfoPeople> listCyxx = ygjzjtxxcyxxDao.queryNoPage(map);

		// 1,计算医疗指数
		double medicalScore = getMedicalScore(familyId);

		// 2,计算住房指数
		double houseScore = 0;
		String zfzklxdm = ygjzJtxx.getHouseQuality();//住房类型
		String fwzk =ygjzJtxx.getHouseStatus();//房屋状况
		BigDecimal rjjzmj = ygjzJtxx.getBuildAverageArea();//人均建筑面积
		String flag ="0";
		if(zfzklxdm!=null&&!zfzklxdm.equals("")){
			
		if ("1".indexOf(fwzk) != -1 || "100".equals(zfzklxdm)
				&& rjjzmj != null && rjjzmj.doubleValue() <= 10) {
			
			if("100".equals(zfzklxdm) && "2".equals(fwzk)){ // 判断是否为一般危房
				flag = "2"; //一般危房
			}if("100".equals(zfzklxdm) && "3".equals(fwzk)){ // 判断是否为严重危房
				flag = "3"; //严重危房
			}else if("200,210,220,221,222,300".indexOf(zfzklxdm) != -1){
				flag = "4"; // 无房
			}else{
				flag ="1";//有房
			}
			houseScore = getZjzsScore("ZF", flag);
		}
		}
		// 3,计算事故指数
		double accidentScore = getAccidentScore(familyId);
		// 4,计算教育指数
		double educateScore = getEducateScore(familyId);
		// 5,计算自然灾害指数
		double disasterScore = getDisasterScore(familyId);

		// 6,计算养老分数
		double oldPeopleScore = 0;
		// 7,计算失业分数
		double noJobScore = 0;
		int noJobNum = 0;
		for (int i = 0; i < listCyxx.size(); i++) {
			BaseinfoPeople cyxx = listCyxx.get(i);
			// 养老分数
			oldPeopleScore += getOldPeopleScore(cyxx.getBirthday());
			if(cyxx.getEmploymentCode()!=null && !(cyxx.getEmploymentCode()).equals("")){
				if ("60,61,62".indexOf(cyxx.getEmploymentCode())!=-1){
					noJobNum++;
				}
			}
		}
		if (noJobNum > 0) {
			if (noJobNum == listCyxx.size()) {
				noJobScore = getNoJobScore("2");
			} else {
				noJobScore = noJobNum * getNoJobScore("1");
			}
		}

		// 8,计算残疾指数
		double deformityScore = getDeformityScore(familyId);

		// 9,计算单亲分数
		double oneParentScore = 0;
		if(ygjzJtxx.getAssistanceType()!=null&&!(ygjzJtxx.getAssistanceType()).equals("")){
		if (ygjzJtxx.getAssistanceType().indexOf("07") != -1) {
			oneParentScore = getZjzsScore("DQ", "1");
		}
		}
		double[] scoreArr = new double[]{
				medicalScore, houseScore,
				accidentScore, educateScore, oldPeopleScore, disasterScore,
				deformityScore, noJobScore, oneParentScore
		};
		// 10,计算减分
		reduceAlreadyJzScore(scoreArr, familyId);
		// 11,计算综合指数
		double averageScore = getAverageScore(scoreArr);

		// 保存救助指数信息
		SamIndex ygjzJzzs = new SamIndex();
		ygjzJzzs.setFamilyId(familyId);
		ygjzJzzs.setMedicalIndex(new BigDecimal(scoreArr[0]));
		ygjzJzzs.setHousingIndex(new BigDecimal(scoreArr[1]));
		ygjzJzzs.setAccidentIndex(new BigDecimal(scoreArr[2]));
		ygjzJzzs.setEduIndex(new BigDecimal(scoreArr[3]));
		ygjzJzzs.setSupportIndex(new BigDecimal(scoreArr[4]));
		ygjzJzzs.setCalamityIndex(new BigDecimal(scoreArr[5]));
		ygjzJzzs.setDeformityIndex(new BigDecimal(scoreArr[6]));
		ygjzJzzs.setUnemployedIndex(new BigDecimal(scoreArr[7]));
		ygjzJzzs.setSingleIndex(new BigDecimal(scoreArr[8]));
		ygjzJzzs.setCompositeIndex(new BigDecimal(averageScore));
		map = new HashMap<String, String>();
		map.put("FAMILY_ID", familyId);
		List list = ygjzjzzsDao.queryNoPage(map);
		if (list.size() > 0) {
			ygjzJzzs.setState(Record.STATE_MODIFIED);
			ygjzjzzsDao.update(ygjzJzzs);
		} else {
			ygjzJzzs.setState(Record.STATE_NEW);
			ygjzjzzsDao.insert(ygjzJzzs);
		}
	}

	/**
	 * 减去已救助分数
	 * @return
	 */
	private void reduceAlreadyJzScore(double[] scoreArr, String familyId) {
		List alreadyJzist = this.ygjzjtxxDao.getAlreadyJzList(familyId);
		for (int i = 0; i < alreadyJzist.size(); i++) {
			HashMap map = (HashMap) alreadyJzist.get(i);
			String jzfx = n2b((String) map.get("ASSISTED_SIDE"));
			int alreadyTimes = ((BigDecimal) map.get("ALREADY_TIMES"))
					.intValue();
			double moneyInAYear = ((BigDecimal) map.get("MONEY_INAYEAR"))
					.doubleValue();
			if (jzfx.equals("")) {
			} else if (jzfx.equals("YL")) {
				String itemCode = "";
				if (moneyInAYear > 3000) {
					itemCode = "a"; // 一年内得到30000元以上救助
				} else if (moneyInAYear > 0 && moneyInAYear < 3000) {
					itemCode = "b"; // 一年内得到30000元以下救助
				}
				scoreArr[0] += getZjzsScore(jzfx, itemCode);
				if (alreadyTimes > 0) {
					scoreArr[0] += alreadyTimes * getZjzsScore(jzfx, "c"); // 一年之前每得到一次救助
				}
			} else if (jzfx.equals("ZF")) {
				if (moneyInAYear > 0) {
					scoreArr[1] += getZjzsScore(jzfx, "a"); // 一年内得到过救助
				}
				if (alreadyTimes > 0) {
					scoreArr[1] += alreadyTimes * getZjzsScore(jzfx, "b"); // 一年之前每得到一次救助
				}
			} else if ("SG,JY,LR,ZH,CJ,SY,DQ".indexOf(jzfx) != -1) {
				String itemCode = "";
				if (moneyInAYear > 5000) {
					itemCode = "a"; // 一年内得到5000元以上救助
				} else if (moneyInAYear > 0 && moneyInAYear < 5000) {
					itemCode = "b"; // 一年内得到5000元以下救助
				}
				// 注意，顺序是固定的
				int idx = "SG,JY,LR,ZH,CJ,SY,DQ".indexOf(jzfx) / 3;
				scoreArr[2 + idx] += getZjzsScore(jzfx, itemCode);
				if (alreadyTimes > 0) {
					scoreArr[2 + idx] += alreadyTimes * getZjzsScore(jzfx, "c"); // 一年之前每得到一次救助
				}
			}
		}
	}

	/**
	 * 得到综合分数
	 *
	 * @return
	 */
	private double getAverageScore(double[] scoreArr) {
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("HELP_ORGAN_REGION", BspUtil.getOrganCode().substring(0,4));
		//根据各地的不同情况设定救助指数参数
		//TODO
		List<YgjzJzzsConf> list = YgjzJzzsConfDao.queryNoPage(map);
		double averageScore = 0;
		if(list.size()>0){
			YgjzJzzsConf ygjzJzzsConf = (YgjzJzzsConf) list.get(0);
			String[] zslxArr = ygjzJzzsConf.getHelpType().split(",");
			String[] zsqzArr = ygjzJzzsConf.getHelpPer().split(",");
	
			
			for (int i = 0; i < zslxArr.length; i++) {
				if (zslxArr[i].equals("YL")) {
					averageScore += scoreArr[0] * Double.parseDouble(zsqzArr[i])
							/ 100;
				} else if (zslxArr[i].equals("ZF")) {
					averageScore += scoreArr[1] * Double.parseDouble(zsqzArr[i])
							/ 100;
				} else if (zslxArr[i].equals("SG")) {
					averageScore += scoreArr[2] * Double.parseDouble(zsqzArr[i])
							/ 100;
				} else if (zslxArr[i].equals("JY")) {
					averageScore += scoreArr[3] * Double.parseDouble(zsqzArr[i])
							/ 100;
				} else if (zslxArr[i].equals("LR")) {
					averageScore += scoreArr[4] * Double.parseDouble(zsqzArr[i])
							/ 100;
				} else if (zslxArr[i].equals("ZH")) {
					averageScore += scoreArr[5] * Double.parseDouble(zsqzArr[i])
							/ 100;
				} else if (zslxArr[i].equals("CJ")) {
					averageScore += scoreArr[6] * Double.parseDouble(zsqzArr[i])
							/ 100;
				} else if (zslxArr[i].equals("SY")) {
					averageScore += scoreArr[7] * Double.parseDouble(zsqzArr[i])
							/ 100;
				} else if (zslxArr[i].equals("DQ")) {
					averageScore += scoreArr[8] * Double.parseDouble(zsqzArr[i])
							/ 100;
				}
			}
				
		}
			return averageScore;
	}

	/**
	 * 得到养老分数
	 *
	 * @param birthday
	 * @return
	 */
	private double getOldPeopleScore(String birthday) {
		double score = 0;
		if(birthday!=null&&!birthday.equals("")){
		if (getDatebyAddYears("yyyyMMdd", -80).compareTo(birthday) >= 0) {
			score = getZjzsScore("LR", "3");
		} else if (getDatebyAddYears("yyyyMMdd", -70).compareTo(birthday) >= 0) {
			score = getZjzsScore("LR", "2");
		} else if (getDatebyAddYears("yyyyMMdd", -60).compareTo(birthday) >= 0) {
			score = getZjzsScore("LR", "1");
		}
		}
		return score;
	}

	/**
	 * 得到失业分数
	 *
	 * @param birthday
	 * @return
	 */
	private double getNoJobScore(String status) {
		double score = 0;
		score = getZjzsScore("SY", status);
		return score;
	}

	/**
	 * 得到教育分数
	 *
	 * @param birthday
	 * @return
	 */
	private double getEducateScore(String familyId) {
		double score = 0;
		List needJyJzList = this.ygjzjtxxDao.getNeedJyJzList(familyId);
		for (int i = 0; i < needJyJzList.size(); i++) {
			HashMap map = (HashMap) needJyJzList.get(i);
			String jyzk = (String) map.get("EDUCATION");
			String grade = (String) map.get("GRADE");
			int nj = 0;
			if(grade != null){
			//	nj = (grade).intValue();
				nj = Integer.parseInt(grade);
			}
			if (jyzk.equals("80") || jyzk.equals("70")) {
				score += getZjzsScore("JY", "1");
			} else if (jyzk.equals("60") || "20,30".indexOf(jyzk) != -1 && nj == 1) {
				score += getZjzsScore("JY", "2");
			} else if ("20,30".indexOf(jyzk) != -1 && nj > 1) {
				score += getZjzsScore("JY", "3");
			}
		}
		return score;
	}

	/**
	 * 得到灾害分数
	 *
	 * @param birthday
	 * @return
	 */
	private double getDisasterScore(String familyId) {
		double score = 0;
		HashMap map = new HashMap();
		map.put("FAMILY_ID", familyId);
		List ygjzjtxxzrzhList = ygjzjtxxzrzhDao.queryNoPage(map);
		for (int i = 0; i < ygjzjtxxzrzhList.size(); i++) {
			SamFamilyCalamity zh = (SamFamilyCalamity) ygjzjtxxzrzhList.get(i);
			String item = "";
			if (zh.getLossMon() != null) {
				item = String.valueOf(zh.getLossMon());
			}
			score += getZjzsScore("ZH", item);
		}
		return score;
	}

	/**
	 * 得到事故分数
	 *
	 * @param birthday
	 * @return
	 */
	private double getAccidentScore(String familyId) {
		double score = 0;
		List list = this.ygjzjtxxDao.getSgSsMoneyList(familyId);
		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);

			String item = "";
			if (map.get("LOSS_MON") != null) {
			//	item = String.valueOf(((BigDecimal) map.get("LOSS_MON")).intValue());
				item = (String) map.get("LOSS_MON");
			}
			score += getZjzsScore("SG", item);
		}
		return score;
	}

	/**
	 * 得到医疗分数
	 *
	 * @param familyId
	 * @return
	 */
	private double getMedicalScore(String familyId) {
		double score = 0;
		List list = this.ygjzjtxxDao.getMedicalJzList(familyId);
		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);
			String item = "";
			if (map.get("COST_MON") != null) {
			//	item = String.valueOf(((BigDecimal) map.get("YLZC_JE")).intValue());
				item = (String) map.get("COST_MON");
			}
			score += getZjzsScore("YL", item);
		}
		return score;
	}

	/**
	 * 得到残疾分数
	 *
	 * @param familyId
	 * @return
	 */
	private double getDeformityScore(String familyId) {
		double score = 0;
		List list = this.ygjzjtxxDao.getDeformityJzList(familyId);
		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);
			String CJDJ = (String) map.get("DISABILITY_LEVEL");
			score += getZjzsScore("CJ", CJDJ);
		}
		return score;
	}

	/**
	 * 得到分数
	 *
	 * @param zslx
	 * @param zsxm
	 * @return
	 */
	private double getZjzsScore(String zslx, String zsxm) {
		double score = 0;
		if ("".equals(zslx) || "".equals(zsxm)) {
			return 0;
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("HELP_ORGAN_REGION", BspUtil.getOrganCode().substring(0,4));
		map.put("HELP_TYPE", zslx);
		map.put("HELP_CODE", zsxm);
		List<YgjzJzzsJzfsConf> list = ygjzJzzsJzfsConfDao.queryNoPage(map);
		if (list.size() > 0) {
			YgjzJzzsJzfsConf conf = list.get(0);
			score = conf.getHelpScore().doubleValue();
		}
		return score;
	}

	/**
	 * 得到系统时间
	 *
	 * @param format
	 * @return
	 */
	public static String getDatebyAddYears(String format, int iYear) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, iYear);
		Date date = cal.getTime();
		return sdf.format(date);
	}

	public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzjtxxcyxxDomain.saveYgjzJtxxCyxx(list);
		}
	}

	public DataSet queryYgjzJtxxCyxx(ParameterSet pset) {
		return ygjzjtxxcyxxDao.query(pset);
	}

	public DataSet itemQuery(ParameterSet pset,HttpServletRequest request) {
		return ygjzjtxxcyxxDao.itemQuery(pset,request);
	}
	/**
	 * 家庭信息、成员信息 主表添加全部信息
	 *
	 * @param ygjzjtxx
	 * @param line
	 * @param cjxxlist
	 */
	public void saveYgjzJtxxCyxxList(BaseinfoFamily ygjzjtxx,
			List<BaseinfoPeople> line, List<SamPeopleDisability> cjxxlist,
			List<SamPeopleEdu> jyxxList, List<SamPeopleDisease> hbxxList,
			List<SamPeopleAccident> sgxxList) {
		IYgjzJtxxCyxxDomain service = ScaComponentFactory.getService(
				IYgjzJtxxCyxxDomain.class,
				"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		List ygjzjtxxList = new ArrayList();
		ygjzjtxxList.add(ygjzjtxx);
		this.ygjzjtxxDao.save(ygjzjtxxList);

		if (line != null && !line.isEmpty()) {
			service.saveYgjzJtxxCyxx(line);
		}
		if (cjxxlist != null && !cjxxlist.isEmpty()) {
			service.saveYgjzCyxxCjxx(cjxxlist);
		}
		if (jyxxList != null && !jyxxList.isEmpty()) {
			service.saveYgjzCyxxJyxx(jyxxList);
		}
		if (hbxxList != null && !hbxxList.isEmpty()) {
			service.saveYgjzCyxxHbxx(hbxxList);
		}
		if (sgxxList != null && !sgxxList.isEmpty()) {
			service.saveYgjzCyxxSgxx(sgxxList);
		}
	}


	@Reference
	public void setYgjzJtxxZrzhDao(IYgjzJtxxZrzhDao ygjzjtxxzrzhDao) {
		this.ygjzjtxxzrzhDao = ygjzjtxxzrzhDao;
	}

	public void saveYgjzJtxxZrzh(List<SamFamilyCalamity> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzjtxxzrzhDao.save(list);
		}
	}

	public DataSet queryYgjzJtxxZrzh(ParameterSet pset) {
		return ygjzjtxxzrzhDao.query(pset);
	}

	public void saveYgjzJtxxZrzhList(BaseinfoFamily ygjzjtxx, List<SamFamilyCalamity> line) {
		List ygjzjtxxList = new ArrayList();
		ygjzjtxxList.add(ygjzjtxx);
		this.ygjzjtxxDao.save(ygjzjtxxList);
		if (line != null && !line.isEmpty()) {
			this.ygjzjtxxzrzhDao.save(line);
		}
	}

	@Reference
	public void setYgjzJzzsDao(IYgjzJzzsDao ygjzjzzsDao) {
		this.ygjzjzzsDao = ygjzjzzsDao;
	}

	public void saveYgjzJzzs(List<SamIndex> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzjzzsDao.save(list);
		}
	}

	public DataSet queryYgjzJzzs(ParameterSet pset) {
		return ygjzjzzsDao.query(pset);
	}

	public void saveYgjzJzzsList(BaseinfoFamily ygjzjtxx, List<SamIndex> line) {
		List ygjzjtxxList = new ArrayList();
		ygjzjtxxList.add(ygjzjtxx);
		this.ygjzjtxxDao.save(ygjzjtxxList);
		if (line != null && !line.isEmpty()) {
			this.ygjzjzzsDao.save(line);
		}
	}

	public void delete(List<String> list) {
		String[] ygjzjtxxIds = list.toArray(new String[list.size()]);

		if (list != null && !list.isEmpty()) {
			this.ygjzjtxxDao.batchDelete(ygjzjtxxIds);
		}

	}

	public DataSet queryYgjzJtxx(ParameterSet pset) {
		return ygjzjtxxDao.query(pset);
	}

	public void setYgjzjtxxcyxxDomain(IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain) {
		this.ygjzjtxxcyxxDomain = ygjzjtxxcyxxDomain;
	}

	public IYgjzJzzsDao getYgjzjzzsDao() {
		return ygjzjzzsDao;
	}

	public void setYgjzjzzsDao(IYgjzJzzsDao ygjzjzzsDao) {
		this.ygjzjzzsDao = ygjzjzzsDao;
	}

	// 更新成员数量
	public void updatePeopleNum(String familyId) {
		this.ygjzjtxxDao.updatePeopleNum(familyId);
	}

	// 更改当前环节
	public void updateCurrentActivity(String activity, String jtids,String createOrgan) {
		this.ygjzjtxxDao.updateCurrentActivity(activity, jtids,createOrgan);
	}

	public void saveYgjzJtxxSzlx(List<SamFamilyAssistance> list) {
		// TODO Auto-generated method stub

	}
	private String n2b(String str){
		return str == null ? "" : str.trim();
	}

	/*public void updateJtdz(String jtids) {
		this.ygjzjtxxDao.updateJtdz(jtids);
	}*/
	 //变更页面点提交按钮时，先批量删除救助类型记录，再执行保存方法
	public void saveSamFamilyAssistance(List<SamFamilyAssistance> list, String familyId) {
        //先根据familyId删除相关的救助记录
		samFamilyAssistanceDao.deleteByFamilyId(familyId);
		//循环保存修改后的救助记录
		for(int i=0;i<list.size();i++){
			SamFamilyAssistance bean=list.get(i);
			samFamilyAssistanceDao.insert(bean);
		}
	}

	public DataSet querySamFamilyAssistance(ParameterSet pset) {
		return samFamilyAssistanceDao.query(pset);
	}

	public void saveSamFamilyAssistanceList(BaseinfoFamily ygjzjtxx, List<SamFamilyAssistance> line) {
		List<BaseinfoFamily> ygjzjtxxList = new ArrayList<BaseinfoFamily>();
		ygjzjtxxList.add(ygjzjtxx);
		this.ygjzjtxxDao.save(ygjzjtxxList);
		if (line != null && !line.isEmpty()) {
			this.samFamilyAssistanceDao.save(line);
		}
	}
	/*
	 * jiang 批量插入救助类型
	 * @see com.inspur.cams.drel.sam.domain.IBaseinfoFamilyDomain#saveSamFamilyAssistance(java.util.List)
	 */
	public void saveSamFamilyAssistance(List<SamFamilyAssistance> list) {
		for(int i=0;i<list.size();i++){
			SamFamilyAssistance somA=(SamFamilyAssistance)list.get(i);
			samFamilyAssistanceDao.insert(somA);
		}
	}
	/**
	 * 批量删除
	 * 
	 */
	public void bathchDeleteByFamilyId(String[] delIds){
		samFamilyAssistanceDao.bathchDeleteByFamilyId(delIds);
	}
	//新增房屋基本信息
	 public void HouseInsert(SamFamilyHouse samFamilyHouse){
		 samfamilyHouseDao.insert(samFamilyHouse);
	 }
	 public void HouseUpdate(SamFamilyHouse samFamilyHouse){
		 samfamilyHouseDao.update(samFamilyHouse);
	 }
	//新增外部单位信息
	 public void FamilyInsert(ComFamilyOrgan comFamilyOrgan){
		 comfamilyOrganDao.insert(comFamilyOrgan);
	 }
	 public void FamilyUpdate(ComFamilyOrgan comFamilyOrgan){
		 comfamilyOrganDao.update(comFamilyOrgan);
	 }
}