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
import com.inspur.cams.drel.info.dao.ID204c30Dao;
import com.inspur.cams.drel.info.data.D204c22;
import com.inspur.cams.drel.info.data.D204c30;
import com.inspur.cams.drel.info.domain.ID204c30Domain;
import com.inspur.cams.drel.temp.dao.ID204c22TempDao;
import com.inspur.cams.drel.temp.dao.ID204c30TempDao;

/**
 * 贵金属domain
 * @author 
 * @date 2014-06-09
 */
public class D204c30Domain implements ID204c30Domain {

	@Reference
	private ID204c30Dao d204c30Dao;
	@Reference
	private IFeedBackDao feedBackDao;
	@Reference
	private ID204c30TempDao d204c30TempDao;
	/**
	 * 查询 贵金属
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c30Dao.query(pset);
	}

	/**
	 * 获取 贵金属
	 * @param pset
	 * @return
	 */
	public D204c30 get(String d204c30Id) {
		return d204c30Dao.get(d204c30Id);
	}

	/**
	 * 增加 贵金属
	 * @param d204c30
	 */
	public void insert(D204c30 d204c30) {
		d204c30.setD204c30Id(IdHelp.getUUID32());
		d204c30.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204c30.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204c30.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204c30.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204c30.setInputTime(DateUtil.getTime());
		d204c30Dao.insert(d204c30);
	}
	
	/**
	 * 修改 贵金属
	 * @param d204c30
	 */
	public void update(D204c30 d204c30) {
		d204c30Dao.update(d204c30);
	}
	
	/**
	 * 删除 贵金属
	 * @param d204c30Id
	 */
	public void delete(String d204c30Id) {
		d204c30Dao.delete(d204c30Id);
	}
	public void insertFromTemp(Record[] records) {
		// TODO Auto-generated method stub
		List<D204c30> list = new ArrayList<D204c30>();
		String[] mainIds = new String[records.length];
		for(int i=0;i<records.length;i++){
			Record r =records[i];
			D204c30 d = new D204c30();
			mainIds[i]=(String)r.get("D204D30_ID");
			//d.setCommissionId((String)r.get("COMMID"));
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILY_ID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			d.setD204c300001((String)r.get("D204C300001"));
			d.setD204c300002("".equals(r.get("D204C300002"))?null:new BigDecimal(r.get("D204C300002")+""));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			
			d.setD204c30Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			d.setSourceType("1");
			
			list.add(d);
		}
		d204c30Dao.batchInsert(list);
		d204c30TempDao.batchUpdateStatus(mainIds);
	}
	public void batchInsertFromTemp(ParameterSet pset) {
		// TODO Auto-generated method stub
		pset.setParameter("ifNopage", "1");
		DataSet ds = feedBackDao.queryCompareResultInfo(pset);
		List<D204c30> list = new ArrayList<D204c30>();
		String[] mainIds = new String[ds.getCount()];
		for(int i=0;i<ds.getCount();i++){
			Record r =ds.getRecord(i);
			mainIds[i]=(String)r.get("D204D30_ID");
			D204c30 d = new D204c30();
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILYID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			d.setD204c300001((String)r.get("D204C300001"));
			d.setD204c300002(new BigDecimal(r.get("D204C300002")+""));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");
			
			d.setD204c30Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			
			list.add(d);
		}
		d204c30Dao.batchInsert(list);
		d204c30TempDao.batchUpdateStatus(mainIds);
	}
}