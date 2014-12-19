package com.inspur.cams.bpt.bptinstitution.cmd;

import java.util.*;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptHospitalLegalDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalDetailDao;
import com.inspur.cams.bpt.bptinstitution.data.BptHospital;
import com.inspur.cams.bpt.bptinstitution.data.BptHospitalDetail;
import com.inspur.cams.bpt.bptinstitution.data.BptHospitalLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptHospitalDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptHospitalSaveCommand
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
public class BptHospitalCommand extends BaseAjaxCommand {
	IBptHospitalDetailDao bptHospitalDetailDao = (IBptHospitalDetailDao) DaoFactory
    .getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptHospitalDetailDao");

	private String hospitalId = IdHelp.getUUID30();
	@Trans
	public void save() {
		IBptHospitalDomain service = ScaComponentFactory.getService(IBptHospitalDomain.class,
				"BptHospitalDomain/BptHospitalDomain");
		BptHospital bpthospital = getBptHospital();
		BptHospitalDetail bpthospitaldetail = getBptHospitalDetail();
		if(bpthospital.getHospitalId()==null||"".equals(bpthospital.getHospitalId())){
			bpthospital.setHospitalId(hospitalId);
		}else{
			bpthospital.setState(3);
		}
		bpthospital.setRegOrganCode(BspUtil.getOrganCode());
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ID", bpthospital.getHospitalId()+bpthospitaldetail.getYears());
		DataSet ds = bptHospitalDetailDao.query(pset);
		BptHospitalLegal bptHospitalLegal = getBptHospitalLegal();
		bptHospitalLegal.setLegalId(IdHelp.getUUID30());
		bptHospitalLegal.setHospitalDetailId(hospitalId+bpthospitaldetail.getYears());
		List<BptHospitalLegal> BptHospitalLegalList = new ArrayList<BptHospitalLegal>();
		BptHospitalLegalList.add(bptHospitalLegal);
		service.saveBptHospitalLegalList(bpthospital, BptHospitalLegalList);
		if(ds.getCount()<1) {
			//+bpthospitaldetail.getYears()
			bpthospitaldetail.setId(bpthospital.getHospitalId()+bpthospitaldetail.getYears());
			bpthospitaldetail.setHospitalId(bpthospital.getHospitalId());
			bptHospitalDetailDao.insert(bpthospitaldetail);
		} else {
			bptHospitalDetailDao.update(bpthospitaldetail);
		}

	}
	/**
	 * 更新年度信息
	 */
	@Trans
	public void updateYear(){
		IBptHospitalDomain service = ScaComponentFactory.getService(IBptHospitalDomain.class,
		"BptHospitalDomain/BptHospitalDomain");
		BptHospital bpthospital = getBptHospital();
		bpthospital.setRegOrganCode(BspUtil.getOrganCode());
		
		
		BptHospitalDetail bpthospitaldetail = getBptHospitalDetail();
		bpthospitaldetail.setState(3);
		String year = (String)bpthospitaldetail.getYears();
		String hospitalId = (String)bpthospitaldetail.getHospitalId();
		if(getMaxYear(year,hospitalId)){//最新年份时更新bpt_hospital表
			bpthospital.setState(3);
		}else{
			bpthospital=null;
		}
		
		BptHospitalLegal bptHospitalLegal = getBptHospitalLegal();
		List<BptHospitalLegal> BptHospitalLegalList = new ArrayList<BptHospitalLegal>();
		BptHospitalLegalList.add(bptHospitalLegal);
		
		service.saveBptHospitalLegalList(bpthospital, BptHospitalLegalList);
		bptHospitalDetailDao.update(bpthospitaldetail);
	}
	
	/**
	 * 优抚医院获取最大的年份
	 * @param year
	 * @param hospitalId
	 * @return
	 */
	public Boolean getMaxYear(String year,String hospitalId){
		IBptHospitalDomain service = ScaComponentFactory.getService(IBptHospitalDomain.class,
		"BptHospitalDomain/BptHospitalDomain");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("hospitalId", hospitalId);
		DataSet ds =service.getMaxYear(pset);
		if(ds.getCount()>0){
			String y = (String)ds.getRecord(0).get("MX");
			if(y!=null&&year!=null&&!"".equals(year)){
				int y1=Integer.parseInt(y);
				int y2 = Integer.parseInt(year);
				return y2>=y1;
			}
			return true;
		}else{
			return true;
		}
	}
	/**
	 * 插入年度信息
	 */
	@Trans
	public void insertYear(){
		IBptHospitalDomain service = ScaComponentFactory.getService(IBptHospitalDomain.class,
		"BptHospitalDomain/BptHospitalDomain");
		BptHospital bpthospital = getBptHospital();
		//bpthospital.setHospitalId(hospitalId);
		BptHospitalDetail bpthospitaldetail = getBptHospitalDetail();
		bpthospitaldetail.setId(bpthospital.getHospitalId()+bpthospitaldetail.getYears());
		bpthospitaldetail.setHospitalId(bpthospital.getHospitalId());
		
		
		String year = (String)bpthospitaldetail.getYears();
		String hospitalId = (String)bpthospitaldetail.getHospitalId();
		
		BptHospitalLegal bptHospitalLegal = getBptHospitalLegal();
		bptHospitalLegal.setLegalId(IdHelp.getUUID30());
		bptHospitalLegal.setHospitalDetailId(bpthospital.getHospitalId()+bpthospitaldetail.getYears());
		List<BptHospitalLegal> BptHospitalLegalList = new ArrayList<BptHospitalLegal>();
		BptHospitalLegalList.add(bptHospitalLegal);
		bptHospitalLegal.setState(1);//设置状态为新增
		
		if(getMaxYear(year,hospitalId)){//最新年份时更新bpt_hospital表
			bpthospital.setState(3);
		}else{
			bpthospital=null;
		}
		service.saveBptHospitalLegalList(bpthospital, BptHospitalLegalList);
		bptHospitalDetailDao.insert(bpthospitaldetail);
	}
	/**
	 * 插入年度信息
	 */
	@Trans
	public void insert(){
		IBptHospitalDomain service = ScaComponentFactory.getService(IBptHospitalDomain.class,
		"BptHospitalDomain/BptHospitalDomain");
		BptHospital bpthospital = getBptHospital();
		bpthospital.setHospitalId(hospitalId);
		bpthospital.setRegOrganCode(BspUtil.getOrganCode());
		BptHospitalDetail bpthospitaldetail = getBptHospitalDetail();
		bpthospitaldetail.setId(bpthospital.getHospitalId()+bpthospitaldetail.getYears());
		bpthospitaldetail.setHospitalId(bpthospital.getHospitalId());
		
		BptHospitalLegal bptHospitalLegal = getBptHospitalLegal();
		bptHospitalLegal.setLegalId(IdHelp.getUUID30());
		bptHospitalLegal.setHospitalDetailId(bpthospital.getHospitalId()+bpthospitaldetail.getYears());
		List<BptHospitalLegal> BptHospitalLegalList = new ArrayList<BptHospitalLegal>();
		BptHospitalLegalList.add(bptHospitalLegal);
		
		service.saveBptHospitalLegalList(bpthospital, BptHospitalLegalList);
		bptHospitalDetailDao.insert(bpthospitaldetail);
	}
	@Trans
	public void delete() {
		IBptHospitalDomain service = ScaComponentFactory.getService(IBptHospitalDomain.class,
				"BptHospitalDomain/BptHospitalDomain");
		String[] delId = (String[]) getParameter("delIds");
		List list = new ArrayList();
		for(int i=0;i<delId.length;i++){
			list.add(delId[i]);
		}
		
		/*BptHospitalLegalDao bpthospitallegalDao = null;
		try{
			bpthospitallegalDao = new BptHospitalLegalDao();
		}catch(Exception e){
			
		}
		bpthospitallegalDao.batchDeleteByBptHospital(delId);*/
		
		service.delete(list);
	}
	@Trans
	public void hospitalDelete() {
		IBptHospitalDomain service = ScaComponentFactory.getService(IBptHospitalDomain.class,
		"BptHospitalDomain/BptHospitalDomain");
		String[] idList = (String[])getParameter("idList");
		service.hospitalDelete(idList);
		
	}
	private BptHospital getBptHospital() {
		Record bpthospitalRecord = (Record) getParameter("BptHospitalRecord");
		BptHospital bean=(BptHospital) bpthospitalRecord.toBean(BptHospital.class);
		bean.setRegOrganCode(BspUtil.getOrganCode());
		return bean;
	}
	private BptHospitalDetail getBptHospitalDetail() {
		Record bpthospitalRecord = (Record) getParameter("BptHospitalRecord");
		return (BptHospitalDetail) bpthospitalRecord.toBean(BptHospitalDetail.class);
	}
	
	/*private List<BptHospitalLegal> getBptHospitalLegalList() {
		Record[] bpthospitallegalRecords = (Record[]) getParameter("BptHospitalLegalRecords");
		if (bpthospitallegalRecords == null || bpthospitallegalRecords.length == 0) {
			return null;
		}
		List<BptHospitalLegal> list = new ArrayList<BptHospitalLegal>();
		for (int i = 0; i < bpthospitallegalRecords.length; i++) {
			BptHospitalLegal bpthospitallegal = (BptHospitalLegal) bpthospitallegalRecords[i].toBean(BptHospitalLegal.class);
			if(bpthospitallegal.isNew()){
				bpthospitallegal.setLegalId(IdHelp.getUUID30());
				bpthospitallegal.setHospitalDetailId(hospitalId+bpthospitaldetail.getYears());
			}
			list.add(bpthospitallegal);
		}

		return list;
	}*/
	
	private BptHospitalLegal getBptHospitalLegal() {
		Record BptHospitalLegalRecord = (Record) getParameter("BptHospitalLegalRecord");
		BptHospitalLegal bpthospitallegal = (BptHospitalLegal) BptHospitalLegalRecord.toBean(BptHospitalLegal.class);
		return bpthospitallegal;
	}
	
	public void isYearHave(){
		ParameterSet pset = getParameterSet();
		DataSet ds = bptHospitalDetailDao.query(pset);
		if(StringUtils.isEmpty((String)pset.getParameter("hospital_id"))){
			this.setReturn("year", 0);
		}else if(ds.getCount()>0){
			this.setReturn("year", 1);
		}else {
			this.setReturn("year", 0);
		}
	}
}