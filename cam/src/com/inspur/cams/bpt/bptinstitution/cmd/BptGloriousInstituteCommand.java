package com.inspur.cams.bpt.bptinstitution.cmd;

import java.util.*;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousDetailDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousLegalDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalDetailDao;
import com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptGloriousLegalDao;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousDetail;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousInstitute;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousLegal;
import com.inspur.cams.bpt.bptinstitution.data.BptHospitalLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptGloriousInstituteDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptGloriousInstituteSaveCommand
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
 */
public class BptGloriousInstituteCommand extends BaseAjaxCommand {
	private String gloriousid = IdHelp.getUUID30();// 定义光荣院的ID
	IBptGloriousDetailDao BbptGloriousdetaildao = (IBptGloriousDetailDao) DaoFactory
			.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptGloriousDetailDao");
	IBptGloriousLegalDao bptGloriousLegalDao = (IBptGloriousLegalDao) DaoFactory
	.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptGloriousLegalDao");
	@Trans
	public void save() {
		IBptGloriousInstituteDomain service = ScaComponentFactory.getService(
				IBptGloriousInstituteDomain.class,
				"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		BptGloriousInstitute bptgloriousinstitute = getBptGloriousInstitute();
		BptGloriousDetail bptgloriousdetail = getBptGloriousDetail();
		if (bptgloriousinstitute.getGloriousId()==null||"".equals(bptgloriousinstitute.getGloriousId())) {
			bptgloriousinstitute.setGloriousId(gloriousid);// 写入光荣院ID
		}else{
			bptgloriousinstitute.setState(3);
		}
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ID", bptgloriousinstitute.getGloriousId()
				+ bptgloriousdetail.getYears());
		DataSet ds = BbptGloriousdetaildao.query(pset);
		List BptGloriousLegalList = getBptGloriousLegalList();
		service.saveBptGloriousLegalList(bptgloriousinstitute,
				BptGloriousLegalList);
		if (ds.getCount() < 1) {
			// +bpthospitaldetail.getYears()
			bptgloriousdetail.setId(bptgloriousinstitute.getGloriousId()
					+ bptgloriousdetail.getYears());
			bptgloriousdetail.setGloriousId(bptgloriousinstitute
					.getGloriousId());
			BbptGloriousdetaildao.insert(bptgloriousdetail);
		} else {
			BbptGloriousdetaildao.update(bptgloriousdetail);
		}
	}
	@Trans
	public void insert(){
		IBptGloriousInstituteDomain service = ScaComponentFactory.getService(
				IBptGloriousInstituteDomain.class,
				"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		BptGloriousInstitute bptgloriousinstitute = getBptGloriousInstitute();
		bptgloriousinstitute.setGloriousId(gloriousid);
		
		BptGloriousDetail bptgloriousdetail = getBptGloriousDetail();
		bptgloriousdetail.setId(bptgloriousinstitute.getGloriousId()
				+ bptgloriousdetail.getYears());
		bptgloriousdetail.setGloriousId(bptgloriousinstitute
				.getGloriousId());
		
		BptGloriousLegal bptGloriousLegal = getBptGlriousLegal();
		bptGloriousLegal.setGloriousDetailId(bptgloriousinstitute.getGloriousId()
				+ bptgloriousdetail.getYears());
		bptGloriousLegal.setLegalId(IdHelp.getUUID30());
		List<BptGloriousLegal> bptGloriousLegalList = new ArrayList<BptGloriousLegal>();
		bptGloriousLegalList.add(bptGloriousLegal);
		
		service.saveBptGloriousLegalList(bptgloriousinstitute,bptGloriousLegalList);
		BbptGloriousdetaildao.insert(bptgloriousdetail);
	}
	@Trans
	public void insertYear(){
		IBptGloriousInstituteDomain service = ScaComponentFactory.getService(
				IBptGloriousInstituteDomain.class,
				"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		BptGloriousInstitute bptgloriousinstitute = getBptGloriousInstitute();
		
		BptGloriousDetail bptgloriousdetail = getBptGloriousDetail();
		bptgloriousdetail.setId(bptgloriousinstitute.getGloriousId()+ bptgloriousdetail.getYears());
		bptgloriousdetail.setGloriousId(bptgloriousinstitute.getGloriousId());
		
		String year = (String)bptgloriousdetail.getYears();
		String gloriousId = (String)bptgloriousinstitute.getGloriousId();
		
		BptGloriousLegal bptGloriousLegal = getBptGlriousLegal();
		bptGloriousLegal.setGloriousDetailId(bptgloriousinstitute.getGloriousId()
				+ bptgloriousdetail.getYears());
		bptGloriousLegal.setLegalId(IdHelp.getUUID30());
		bptGloriousLegal.setState(1);//设置状态为新增
		
		if(getMaxYear(year,gloriousId)){//最新年份时更新bpt_hospital表
			bptgloriousinstitute.setState(3);
		}else{
			bptgloriousinstitute=null;
		}
		List<BptGloriousLegal> bptGloriousLegalList = new ArrayList<BptGloriousLegal>();
		bptGloriousLegalList.add(bptGloriousLegal);
		
		BbptGloriousdetaildao.insert(bptgloriousdetail);
		service.saveBptGloriousLegalList(bptgloriousinstitute,bptGloriousLegalList);
	}
	@Trans
	public void updateYear(){
		IBptGloriousInstituteDomain service = ScaComponentFactory.getService(
				IBptGloriousInstituteDomain.class,
				"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		BptGloriousInstitute bptgloriousinstitute = getBptGloriousInstitute();
		BptGloriousDetail bptgloriousdetail = getBptGloriousDetail();
		bptgloriousdetail.setState(3);
		String year = (String)bptgloriousdetail.getYears();
		String gloriousId = (String)bptgloriousinstitute.getGloriousId();
		if(getMaxYear(year,gloriousId)){//最新年份时更新光荣院主表
			bptgloriousinstitute.setState(3);
		}else{
			bptgloriousinstitute=null;
		}
		BptGloriousLegal bptGloriousLegal = getBptGlriousLegal();
		List<BptGloriousLegal> bptGloriousLegalList = new ArrayList<BptGloriousLegal>();
		bptGloriousLegalList.add(bptGloriousLegal);
		BbptGloriousdetaildao.update(bptgloriousdetail);
		service.saveBptGloriousLegalList(bptgloriousinstitute,bptGloriousLegalList);
	}
	/**
	 * 优抚医院获取最大的年份
	 * @param year
	 * @param hospitalId
	 * @return
	 */
	public Boolean getMaxYear(String year,String gloriousid){
		IBptGloriousInstituteDomain service = ScaComponentFactory.getService(
				IBptGloriousInstituteDomain.class,
				"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("hospitalId", gloriousid);
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
	@Trans
	public void delete() {
		IBptGloriousInstituteDomain service = ScaComponentFactory.getService(
				IBptGloriousInstituteDomain.class,
				"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		String[] delId = (String[]) getParameter("delIds");
		List list = new ArrayList();
		for (int i = 0; i < delId.length; i++) {
			list.add(delId[i]);
		}

		service.delete(list);
		BbptGloriousdetaildao.batchDeleteByBptGloriousInstitute(delId);
		bptGloriousLegalDao.batchDeleteByGloriousIds(delId);
	}

	// 删除光荣院详细表数据
	@Trans
	public void gloriousDelete() {
		IBptGloriousInstituteDomain service = ScaComponentFactory.getService(
				IBptGloriousInstituteDomain.class,
				"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		String[] idList = (String[]) getParameter("idList");
		BptGloriousLegalDao bptgloriouslegalDao = null;
		try {
			bptgloriouslegalDao = new BptGloriousLegalDao();
		} catch (Exception e) {
			
		}
		service.gloriousDelete(idList);
	}

	private BptGloriousInstitute getBptGloriousInstitute() {
		Record bptgloriousinstituteRecord = (Record) getParameter("BptGloriousInstituteRecord");
		BptGloriousInstitute bean=(BptGloriousInstitute) bptgloriousinstituteRecord
		.toBean(BptGloriousInstitute.class);
		bean.setRegOrganCode(BspUtil.getOrganCode());
		return bean;
	}

	private BptGloriousDetail getBptGloriousDetail() {
		Record bptgloriousinstituteRecord = (Record) getParameter("BptGloriousInstituteRecord");
		return (BptGloriousDetail) bptgloriousinstituteRecord
				.toBean(BptGloriousDetail.class);
	}
	private BptGloriousLegal getBptGlriousLegal(){
		Record bptgloriouslegalRecord = (Record) getParameter("BptGloriousLegalRecord");
		return (BptGloriousLegal) bptgloriouslegalRecord.toBean(BptGloriousLegal.class);
	}
	private List<BptGloriousLegal> getBptGloriousLegalList() {
		Record[] bptgloriouslegalRecords = (Record[]) getParameter("BptGloriousLegalRecords");
		if (bptgloriouslegalRecords == null
				|| bptgloriouslegalRecords.length == 0) {
			return null;
		}

		List<BptGloriousLegal> list = new ArrayList<BptGloriousLegal>();
		for (int i = 0; i < bptgloriouslegalRecords.length; i++) {
			BptGloriousLegal bptgloriouslegal = (BptGloriousLegal) bptgloriouslegalRecords[i]
					.toBean(BptGloriousLegal.class);
			if (bptgloriouslegal.isNew()) {
				bptgloriouslegal.setLegalId(IdHelp.getUUID30());
				bptgloriouslegal.setGloriousDetailId(gloriousid);// 在光荣院法人代表中光荣院ID
			}

			list.add(bptgloriouslegal);
		}

		return list;
	}
	public void isYearHave(){
		ParameterSet pset = getParameterSet();
		DataSet ds = BbptGloriousdetaildao.query(pset);
		if(StringUtils.isEmpty((String)pset.getParameter("glorious_id"))){
			this.setReturn("year", 0);
		}else if(ds.getCount()>0){
			this.setReturn("year", 1);
		}else {
			this.setReturn("year", 0);
		}
	}
}