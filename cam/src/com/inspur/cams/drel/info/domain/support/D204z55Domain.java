package com.inspur.cams.drel.info.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.feedback.dao.IFeedBackDao;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204z55Dao;
import com.inspur.cams.drel.info.data.D204z55;
import com.inspur.cams.drel.info.domain.ID204z55Domain;
import com.inspur.cams.drel.temp.dao.ID204z55TempDao;

/**
 * 优待抚恤信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z55Domain implements ID204z55Domain {

	@Reference
	private ID204z55Dao d204z55Dao;
	@Reference
	private IFeedBackDao feedBackDao;
	@Reference
	private ID204z55TempDao d204z55TempDao;
	/**
	 * 查询 优待抚恤信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z55Dao.query(pset);
	}

	/**
	 * 获取 优待抚恤信息
	 * @param pset
	 * @return
	 */
	public D204z55 get(String d204z55Id) {
		return d204z55Dao.get(d204z55Id);
	}

	/**
	 * 增加 优待抚恤信息
	 * @param d204z55
	 */
	public void insert(D204z55 d204z55) {
		d204z55.setD204z55Id(IdHelp.getUUID32());
		d204z55.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204z55.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204z55.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204z55.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204z55.setInputTime(DateUtil.getTime());
		d204z55Dao.insert(d204z55);
	}
	
	/**
	 * 修改 优待抚恤信息
	 * @param d204z55
	 */
	public void update(D204z55 d204z55) {
		d204z55Dao.update(d204z55);
	}
	
	/**
	 * 删除 优待抚恤信息
	 * @param d204z55Id
	 */
	public void delete(String d204z55Id) {
		d204z55Dao.delete(d204z55Id);
	}
	public void insertFromTemp(Record[] records) {
		// TODO Auto-generated method stub
		List<D204z55> list = new ArrayList<D204z55>();
		String[] mainIds = new String[]{};
		for(int i=0;i<records.length;i++){
			Record r =records[i];
			D204z55 d = new D204z55();
			mainIds[i]=(String)r.get("D204Z55_ID");
			//d.setCommissionId((String)r.get("COMMID"));
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILY_ID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			d.setD204z550001((String)r.get("D204Z550001"));
			d.setD204z550002((String)r.get("D204Z550002"));
			d.setD204z550003("".equals(r.get("D204Z550003"))?null:new BigDecimal((String)r.get("D204Z550003")));
			d.setD204z550004((String)r.get("D204Z550004"));
			d.setD204z550005((String)r.get("D204Z550005"));
			d.setD204z550006((String)r.get("D204Z550006"));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			
			d.setD204z55Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			d.setSourceType("1");
			
			list.add(d);
		}
		d204z55Dao.batchInsert(list);
		d204z55TempDao.batchUpdateStatus(mainIds);
	}
	public void batchInsertFromTemp(ParameterSet pset) {
		// TODO Auto-generated method stub
		pset.setParameter("ifNopage", "1");
		DataSet ds = feedBackDao.queryCompareResultInfo(pset);
		List<D204z55> list = new ArrayList<D204z55>();
		String[] mainIds = new String[]{};
		for(int i=0;i<ds.getCount();i++){
			Record r =ds.getRecord(i);
			mainIds[i]=(String)r.get("D204Z55_ID");
			D204z55 d = new D204z55();
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILYID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			d.setD204z550001((String)r.get("D204Z550001"));
			d.setD204z550002((String)r.get("D204Z550002"));
			d.setD204z550003(new BigDecimal((String)r.get("D204Z550003")));
			d.setD204z550004((String)r.get("D204Z550004"));
			d.setD204z550005((String)r.get("D204Z550005"));
			d.setD204z550006((String)r.get("D204Z550006"));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");
			
			d.setD204z55Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			
			list.add(d);
		}
		d204z55Dao.batchInsert(list);
		d204z55TempDao.batchUpdateStatus(mainIds);
	}
}