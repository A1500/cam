package com.inspur.cams.marry.base.domain.support;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.sam.data.SamApplyFiles;
import com.inspur.cams.marry.base.dao.IMrmBasePersonDao;
import com.inspur.cams.marry.base.dao.IMrmBiWorkingCapacityYearDao;
import com.inspur.cams.marry.base.dao.IMrmBuluDao;
import com.inspur.cams.marry.base.dao.IMrmFdyDao;
import com.inspur.cams.marry.base.dao.IMrmRegisAreaDao;
import com.inspur.cams.marry.base.dao.IMrmRegisOrganInfoDao;
import com.inspur.cams.marry.base.dao.IMrmResourcesInfoDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.data.MrmRegisArea;
import com.inspur.cams.marry.base.data.MrmRegisOrganInfo;
import com.inspur.cams.marry.base.data.MrmResourcesInfo;
import com.inspur.cams.marry.base.domain.IMrmBasePersonDomain;
import com.inspur.cams.marry.base.domain.IMrmRegisOrganInfoDomain;

/**
 * @title:MrmRegisOrganInfoDomain
 * @description:
 * @author:
 * @since:2011-11-26
 * @version:1.0
*/

 public class MrmRegisOrganInfoDomain implements IMrmRegisOrganInfoDomain {
	 private static final String  A_VALUE="001";
	 private static final String  REGION_ZR="898bbe340187500134019681360004";
	 private static final String  PSW="1";
	 private static final String  perName="婚姻登记处管理员";
	private IMrmRegisOrganInfoDao mrmregisorganinfoDao;
	
	private IMrmRegisAreaDao mrmregisareaDao;
	private IMrmResourcesInfoDao mrmresourcesinfoDao;
	
	@Reference
	private IMrmBasePersonDomain mrmBasePersonDomain;
	@Reference
	private IMrmBiWorkingCapacityYearDao mrmBiWorkingCapacityYearDao;
	@Reference
	private IMrmBasePersonDao mrmBasePersonDao;
	@Reference
	private IMrmFdyDao mrmFdyDao;
	@Reference
	private IMrmBuluDao mrmBuluDao;
	/**
	 * 查询所有带等级的登记处
	 * @return
	 */
	public DataSet queryLevelOrgan(ParameterSet pset){
		return mrmregisorganinfoDao.queryLevelOrgan(pset);
	}
	
	public DataSet getOrganInfo(ParameterSet pset) {
		//登记机关基础信息表
		DataSet ds =mrmregisorganinfoDao.query(pset);
		Record record=ds.getRecord(0);
		String deptCode=(String)record.get("deptCode")==null?"":(String)record.get("deptCode");
		String deptName=(String)record.get("name")==null?"":(String)record.get("name");
		String foreign=(String)record.get("foreign")==null?"":(String)record.get("foreign");
		String deptTel=(String)record.get("deptTel")==null?"":(String)record.get("deptTel");
		String homeUrl=(String)record.get("homeUrl")==null?"":(String)record.get("homeUrl");
		String createDate=(String)record.get("creatDate")==null?"":(String)record.get("creatDate");
		
		
		BigDecimal deptNumRy=(BigDecimal)record.get("deptNumRy")==null?new BigDecimal(0):(BigDecimal)record.get("deptNumRy");
		String types=(String)record.get("types")==null?"":(String)record.get("types");
		BigDecimal lastYearBudget=(BigDecimal)record.get("lastYearBudget")==null?new BigDecimal(0):(BigDecimal)record.get("lastYearBudget");
		BigDecimal thisYearBudget=(BigDecimal)record.get("thisYearBudget")==null?new BigDecimal(0):(BigDecimal)record.get("thisYearBudget");
		//信息化建设
		String zxsj=(String)record.get("zxDate")==null?"":(String)record.get("zxDate");
		String lwsj=(String)record.get("lwDate")==null?"":(String)record.get("lwDate");
		String wlyyqysj=(String)record.get("begintime")==null?"":(String)record.get("begintime");
		String sndyyl=(String)record.get("sjyyl")==null?"0":(String)record.get("sjyyl");
		String wlyyl=(String)record.get("wlyul")==null?"0":(String)record.get("wlyul");
		//网络补录时间、数量
		Date earliest=new Date(0);
		BigDecimal amount=new BigDecimal(0);
		List  blInfo=mrmBuluDao.getBuluInfo(deptCode);
		if(blInfo.size()>0){
			 earliest=(Date)((Map)blInfo.get(0)).get("EARLIEST")==null?new Date(0):(Date)((Map)blInfo.get(0)).get("EARLIEST");
			 amount=(BigDecimal)((Map)blInfo.get(0)).get("AMOUNT")==null?new BigDecimal(0):(BigDecimal)((Map)blInfo.get(0)).get("AMOUNT");
		}
		
		//机关场所表
		BigDecimal bzdtArea=mrmregisareaDao.getBzdtArea(deptCode);//颁证大厅面积
		List  fds=mrmregisareaDao.getFdsArea(deptCode);//辅导室面积、间数
		BigDecimal hdChair=mrmregisareaDao.getHdChair(deptCode);//候等区座椅
		BigDecimal tbChair=mrmregisareaDao.getTbChair(deptCode);//填表区座椅
		BigDecimal bzChair=mrmregisareaDao.getBzChair(deptCode);//填表区座椅
		BigDecimal lhArea=mrmregisareaDao.getLhArea(deptCode);//离婚登记区面积
		BigDecimal lhWindow=mrmregisareaDao.getLhWindow(deptCode);//离婚登记区窗口
		BigDecimal marryArea=mrmregisareaDao.getMarryArea(deptCode);//结婚登记区面积
		BigDecimal marryWindow=mrmregisareaDao.getMarryWindow(deptCode);//结婚登记窗口
		BigDecimal wzatd=mrmregisareaDao.getWzatd(deptCode);//有无无障碍通道
		String dnDyjCard=mrmregisareaDao.getdnDyjCard(deptCode);
		String[] dnDyjCards =dnDyjCard.split(",");
		String wcStation=mrmregisareaDao.getWcStation(deptCode);//卫生间位置
		//登记员、颁证员
		BigDecimal djyNum=mrmBasePersonDao.getDjyNum(deptCode);//登记员总数
		BigDecimal bzyNum=mrmBasePersonDao.getBzyNum(deptCode);//颁证员总数
		BigDecimal xzbzNum=mrmBasePersonDao.getXzbzNum(deptCode);//行政编制人员总数
		BigDecimal cgglNum=mrmBasePersonDao.getCgglNum(deptCode);//参公管理事业编制员人员总数
		BigDecimal qebkNum=mrmBasePersonDao.getQebkNum(deptCode);//全额拨款编制总数
		
		BigDecimal fdyNum=mrmFdyDao.getFdyNum(deptCode);
		List fdyry=mrmFdyDao.getFdyRyly(deptCode);
		String qtqksc="";
		String qtqks="";
		int qtqkNum=0;
		int gkzmNum=0;
		int zyzNum=0;
		int zfgmNum=0;
		for (int i=0;i<fdyry.size();i++){
			String ryly =(String)((Map)fdyry.get(i)).get("RYLY")==null?"":(String)((Map)fdyry.get(i)).get("RYLY");
			String qtqk =(String)((Map)fdyry.get(i)).get("QTQK")==null?"":(String)((Map)fdyry.get(i)).get("QTQK");
			if(ryly.equals("04")){//其他情况
				qtqkNum+=1;
				//qtqks+=qtqkNum+"、"+qtqk+"、";
				qtqks+=qtqk+"、";
			}
			if(ryly.equals("03")){//公开招募
				gkzmNum+=1;
			}
			
			if(ryly.equals("02")){//志愿者
				zyzNum+=1;
			}
			
			if(ryly.equals("01")){//政府购买
				zfgmNum+=1;
			}
		}
		
		if(qtqks.length()>1){
			  qtqksc=qtqks.substring(0, qtqks.length()-1);//其他情况拼接
		}
		DataSet newDs=new DataSet();
		Record newRec=new Record();
		//登记机关基础信息表
		newRec.set("deptId", deptCode);
		newRec.set("deptName", deptName);
		newRec.set("foreign", foreign);
		newRec.set("deptTel", deptTel);
		newRec.set("homeUrl", homeUrl);
		newRec.set("deptNumRy", deptNumRy);
		newRec.set("types", types);
		newRec.set("lastYearBudget", lastYearBudget);
		newRec.set("thisYearBudget", thisYearBudget);
		newRec.set("createDate", createDate);
		
		//信息化建设
		newRec.set("wlyyqysj", wlyyqysj);
		newRec.set("wlyyl", wlyyl);
		newRec.set("sndyyl", sndyyl);
		newRec.set("zxsj", zxsj);
		newRec.set("lwsj", lwsj);
		//补录信息
		newRec.set("blsj", earliest);
		newRec.set("blNum", amount);
		//机关场所表
		newRec.set("bzdtArea", bzdtArea==null?new BigDecimal(0):bzdtArea);
		BigDecimal fdsArea=new BigDecimal(0);
		BigDecimal jianShu=new BigDecimal(0);
		if(fds.size()>0){
			 fdsArea=(BigDecimal)((Map)fds.get(0)).get("FUNCTION_AREA")==null?new BigDecimal(0):(BigDecimal)((Map)fds.get(0)).get("FUNCTION_AREA");
			 jianShu=(BigDecimal)((Map)fds.get(0)).get("JIAN_SHU")==null?new BigDecimal(0):(BigDecimal)((Map)fds.get(0)).get("JIAN_SHU");
		}
		newRec.set("fdsArea", fdsArea==null?new BigDecimal(0):fdsArea);
		newRec.set("jianShu", jianShu==null?new BigDecimal(0):jianShu);
		newRec.set("hdChair", hdChair==null?new BigDecimal(0):hdChair);
		newRec.set("tbChair", tbChair==null?new BigDecimal(0):tbChair);
		newRec.set("qyglx", bzChair==null?new BigDecimal(0):bzChair);
		newRec.set("lhArea", lhArea==null?new BigDecimal(0):lhArea);
		newRec.set("lhWindow", lhWindow==null?new BigDecimal(0):lhWindow);
		newRec.set("marryArea", marryArea==null?new BigDecimal(0):marryArea);
		newRec.set("marryWindow", marryWindow==null?new BigDecimal(0):marryWindow);
		newRec.set("wzatd", wzatd==null?new BigDecimal(0):wzatd);
		
		newRec.set("computer", dnDyjCards[0]);//电脑
		newRec.set("printer", dnDyjCards[1]);//打印机
		newRec.set("cardReader", dnDyjCards[2]);//身份识别系统（读卡器）
		//卫生间
		newRec.set("wc",wcStation);
		//资源表
		ParameterSet pse=new ParameterSet();
		String code=(String)pset.get("DEPT_CODE@=")==null?"":(String)pset.get("DEPT_CODE@=");
		pse.setParameter("DEPT_ID@=", code);
		DataSet resourceDs =mrmresourcesinfoDao.query(pse);
		for(int i=0;i<resourceDs.getCount();i++){
			Record  recRec=resourceDs.getRecord(i);
			String resName=(String)recRec.get("resourceName")==null?"":(String)recRec.get("resourceName");
			BigDecimal resNum=(BigDecimal)recRec.get("resourceNum")==null?new BigDecimal(0):(BigDecimal)recRec.get("resourceNum");
			if(resName.equals("01")){
				newRec.set("fyj", resNum);
			}
			if(resName.equals("02")){
				newRec.set("czj", resNum);
			}
			if(resName.equals("03")){
				newRec.set("smy", resNum);
			}
			if(resName.equals("04")){
				newRec.set("dsj", resNum);
			}
			
//			if(resName.equals("05")){//这里的读卡器去掉
//				newRec.set("dkq", resNum);
//			}
			if(resName.equals("06")){
				newRec.set("jhj", resNum);
			}
			if(resName.equals("07")){
				newRec.set("dzxsp", resNum);
			}
			if(resName.equals("08")){
				newRec.set("jksb", resNum);
			}
//			if(resName.equals("09")){
//				newRec.set("qyglx", resNum);
//			}
//			if(resName.equals("10")){
//				newRec.set("wzatd", resNum);
//			}//无障碍通道移至场所表里
			if(resName.equals("10")){
				newRec.set("fwpjxt", resNum);
			}
		}
		
		newDs.add(newRec);
		
		ParameterSet para=new ParameterSet();
		para.setParameter("DEPT_CODE@=", code);
		
		Calendar calendar=Calendar.getInstance();  
		calendar.setTime(new Date()); 
		String yyyy=String.valueOf(calendar.get(Calendar.YEAR)-1); 
		para.setParameter("SUM_DATE@=",yyyy);
		DataSet yearDs=mrmBiWorkingCapacityYearDao.query(para);
		if(yearDs.getCount()>0){
			Record yearRec=yearDs.getRecord(0);
			BigDecimal marryNum=(BigDecimal)yearRec.get("marryNum")==null?new BigDecimal(0):(BigDecimal)yearRec.get("marryNum");
			BigDecimal divorceNum=(BigDecimal)yearRec.get("divorceNum")==null?new BigDecimal(0):(BigDecimal)yearRec.get("divorceNum");
			BigDecimal reissueNum=(BigDecimal)yearRec.get("reissueNum")==null?new BigDecimal(0):(BigDecimal)yearRec.get("reissueNum");
			BigDecimal attestNum=(BigDecimal)yearRec.get("attestNum")==null?new BigDecimal(0):(BigDecimal)yearRec.get("attestNum");
			
			newRec.set("marryNum", marryNum);
			newRec.set("divorceNum", divorceNum);
			newRec.set("reissueNum", reissueNum);
			newRec.set("attestNum", attestNum);
			newRec.set("AllNum", marryNum.intValue()+divorceNum.intValue()+reissueNum.intValue()+attestNum.intValue());
		}else{
			newRec.set("marryNum", 0);
			newRec.set("divorceNum", 0);
			newRec.set("reissueNum", 0);
			newRec.set("attestNum", 0);
			newRec.set("AllNum", 0);
			
		}
	
		
		//登记员、颁证员
		newRec.set("djyNum", djyNum==null?new BigDecimal(0):djyNum);
		newRec.set("bzyNum", bzyNum==null?new BigDecimal(0):bzyNum);
		newRec.set("xzbzNum", xzbzNum==null?new BigDecimal(0):xzbzNum);
		newRec.set("cgglNum", cgglNum==null?new BigDecimal(0):cgglNum);
		newRec.set("qebkNum", qebkNum==null?new BigDecimal(0):qebkNum);
		//辅导员及辅导员来源
		
		newRec.set("fdyNum", fdyNum==null?new BigDecimal(0):fdyNum);
		newRec.set("zfgmNum", zfgmNum);
		newRec.set("zyzNum", zyzNum);
		newRec.set("gkzmNum", gkzmNum);
		newRec.set("qtqksc", qtqksc);
		
		return newDs;
	}
	
	//查询单位
	public DataSet query(ParameterSet pset) {
		return mrmregisorganinfoDao.query(pset);
	}
	//创建现有数据库中所有的登记机关对应的默认登录账号
	@Trans
	public void insertAllPerson() {
		// TODO Auto-generated method stub
		ParameterSet pset=new ParameterSet();
		DataSet ds=mrmregisorganinfoDao.query(pset);
		for(int i=0;i<ds.getCount();i++){
			Record record=ds.getRecord(i);
			MrmBasePerson mrmBasePerson =new MrmBasePerson();
			  String personId = IdHelp.getUUID32();
			  mrmBasePerson.setPersonId(personId);
			  mrmBasePerson.setName(perName);
			  mrmBasePerson.setPwd(PSW);
			  mrmBasePerson.setLoginid((String)record.get("deptCode")==null?"":(String)record.get("deptCode")+A_VALUE);
			  mrmBasePerson.setRoleId(REGION_ZR);//婚姻登记处主任
			  mrmBasePerson.setOrganId((String)record.get("regionCode")==null?"":(String)record.get("regionCode"));
			  mrmBasePerson.setParentOrganId((String)record.get("pubOrganId")==null?"":(String)record.get("pubOrganId"));
			  mrmBasePerson.setDeptId((String)record.get("deptCode")==null?"":(String)record.get("deptCode"));
			  mrmBasePerson.setDeptName((String)record.get("name")==null?"":(String)record.get("name"));
			  mrmBasePersonDomain.insertAll(mrmBasePerson);
		}
	}

	@Trans
	public MrmRegisOrganInfo insert(MrmRegisOrganInfo dataBean,List areaList,List resourceList) {
		// TODO Auto-generated method stub
		  mrmregisorganinfoDao.insert(dataBean);
		  MrmBasePerson mrmBasePerson =new MrmBasePerson();
		  String personId = IdHelp.getUUID32();
		  mrmBasePerson.setPersonId(personId);
		  mrmBasePerson.setName(perName);
		  mrmBasePerson.setPwd(PSW);
		  mrmBasePerson.setLoginid(dataBean.getDeptCode()==null?"":dataBean.getDeptCode()+A_VALUE);
		  mrmBasePerson.setRoleId(REGION_ZR);//婚姻登记处主任
		  mrmBasePerson.setOrganId(dataBean.getRegionCode()==null?"":dataBean.getRegionCode());
		  mrmBasePerson.setParentOrganId(dataBean.getPubOrganId()==null?"":dataBean.getPubOrganId());
		  mrmBasePerson.setDeptId(dataBean.getDeptCode()==null?"":dataBean.getDeptCode());
		  mrmBasePerson.setDeptName(dataBean.getName()==null?"":dataBean.getName());
		  mrmBasePersonDomain.insertAll(mrmBasePerson);//添加
		  if(areaList.size()>0){
			  mrmregisareaDao.save(areaList);
		  }
		  
		  if(resourceList.size()>0){
			  mrmresourcesinfoDao.save(resourceList);
		  }
		return dataBean;
	}
	
	@Trans
	public MrmRegisOrganInfo update(MrmRegisOrganInfo dataBean,List areaList,List resourceList) {
		// TODO Auto-generated method stub
		  mrmregisorganinfoDao.update(dataBean);
		  if(areaList.size()>0){
			  mrmregisareaDao.save(areaList);
		  }
		  
		  if(resourceList.size()>0){
			  mrmresourcesinfoDao.save(resourceList);
		  }
		return dataBean;
	}

	@Reference
	public void setMrmRegisOrganInfoDao(IMrmRegisOrganInfoDao mrmregisorganinfoDao) {
		this.mrmregisorganinfoDao = mrmregisorganinfoDao;
	}

	public void saveMrmRegisOrganInfo(List<MrmRegisOrganInfo> list) {
		this.mrmregisorganinfoDao.save(list);

	}
	@Reference
	public void setMrmRegisAreaDao(IMrmRegisAreaDao mrmregisareaDao) {
		this.mrmregisareaDao = mrmregisareaDao;
	}



	public void saveMrmRegisArea(List<MrmRegisArea> list) {
		if (list != null && !list.isEmpty()) {
			this.mrmregisareaDao.save(list);
		}
	}
	public DataSet queryMrmRegisArea(ParameterSet pset) {
		return mrmregisareaDao.query(pset);
	}
	@Trans
	public void saveMrmRegisAreaList(MrmRegisOrganInfo mrmregisorganinfo, List<MrmRegisArea> line) {
		List mrmregisorganinfoList = new ArrayList();
		mrmregisorganinfoList.add(mrmregisorganinfo);
		this.mrmregisorganinfoDao.save(mrmregisorganinfoList);
		if (line != null && !line.isEmpty()) {
			this.mrmregisareaDao.save(line);
		}
	}
	
	@Reference
	public void setMrmResourcesInfoDao(IMrmResourcesInfoDao mrmresourcesinfoDao) {
		this.mrmresourcesinfoDao = mrmresourcesinfoDao;
	}


	@Trans
	public void saveMrmResourcesInfo(List<MrmResourcesInfo> list) {
		if (list != null && !list.isEmpty()) {
			this.mrmresourcesinfoDao.save(list);
		}
	}
	public DataSet queryMrmResourcesInfo(ParameterSet pset) {
		return mrmresourcesinfoDao.query(pset);
	}
	@Trans
	public void saveMrmResourcesInfoList(MrmRegisOrganInfo mrmregisorganinfo, List<MrmResourcesInfo> line) {
		List mrmregisorganinfoList = new ArrayList();
		mrmregisorganinfoList.add(mrmregisorganinfo);
		this.mrmregisorganinfoDao.save(mrmregisorganinfoList);
		if (line != null && !line.isEmpty()) {
			this.mrmresourcesinfoDao.save(line);
		}
	}
	
	@Trans
	public void delete(List<String> list) {
//		String[] mrmregisorganinfoIds = list.toArray(new String[list.size()]);
//		if (list != null && !list.isEmpty()) {
//			this.mrmregisorganinfoDao.batchDelete(mrmregisorganinfoIds);
//			
//			this.mrmregisareaDao.batchDeleteByMrmRegisOrganInfo(mrmregisorganinfoIds);
//			this.mrmresourcesinfoDao.batchDeleteByMrmRegisOrganInfo(mrmregisorganinfoIds);
//		}

	}

	public DataSet queryMrmRegisOrganInfo(ParameterSet pset) {
		return mrmregisorganinfoDao.query(pset);
	}

	
     /**
	 * 查询婚姻登记处列表
	 * @param pset
	 * @return
	 */
	public DataSet queryOrganInfoList(ParameterSet pset) {
		return mrmregisorganinfoDao.queryOrganInfoList(pset);
	}
	
	/**
	 * 查询总面积
	 * @param deptId
	 * @return
	 */
	public BigDecimal getCountArea(String deptId) {
		return mrmregisareaDao.getCountArea(deptId);
	}
	public void updateWithFile(MrmRegisOrganInfo mrmRegisOrganInfo){
		mrmregisorganinfoDao.updateWithFile(mrmRegisOrganInfo);
	}
	public void setLevel(String applyLevel, String organCode) {
		mrmregisorganinfoDao.setLevel(applyLevel,organCode);
	}
}