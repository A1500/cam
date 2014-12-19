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
import com.inspur.cams.drel.info.dao.ID204z52Dao;
import com.inspur.cams.drel.info.data.D204z52;
import com.inspur.cams.drel.info.domain.ID204z52Domain;
import com.inspur.cams.drel.temp.dao.ID204z52TempDao;

/**
 * 救助信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z52Domain implements ID204z52Domain {

	@Reference
	private ID204z52Dao d204z52Dao;
	@Reference
	private IFeedBackDao feedBackDao;
	@Reference
	private ID204z52TempDao d204z52TempDao;
	/**
	 * 查询 救助信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z52Dao.query(pset);
	}

	/**
	 * 获取 救助信息
	 * @param pset
	 * @return
	 */
	public D204z52 get(String d204z52Id) {
		return d204z52Dao.get(d204z52Id);
	}

	/**
	 * 增加 救助信息
	 * @param d204z52
	 */
	public void insert(D204z52 d204z52) {
		d204z52.setD204z52Id(IdHelp.getUUID32());
		d204z52.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204z52.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204z52.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204z52.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204z52.setInputTime(DateUtil.getTime());
		d204z52Dao.insert(d204z52);
	}
	
	/**
	 * 修改 救助信息
	 * @param d204z52
	 */
	public void update(D204z52 d204z52) {
		d204z52Dao.update(d204z52);
	}
	
	/**
	 * 删除 救助信息
	 * @param d204z52Id
	 */
	public void delete(String d204z52Id) {
		d204z52Dao.delete(d204z52Id);
	}

	public void insertFromTemp(Record[] records) {
		List<D204z52> list = new ArrayList<D204z52>();
		String[] mainIds = new String[records.length];
		for (int i = 0; i < records.length; i++) {
			Record r = records[i];
			D204z52 d = new D204z52();
			mainIds[i]=(String)r.get("D204Z52_ID");
			//d.setCommissionId((String)r.get("COMMID"));
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILY_ID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			// d =(D204c22) r.toBean(D204c22.class);
			d.setD204z520001((String) r.get("D204Z520001"));
			d.setD204z520002((String) r.get("D204Z520002"));
			d.setD204z520003("".equals(r.get("D204D320001"))?null:new BigDecimal(r.get("D204Z520003")+""));
			d.setD204z520004((String) r.get("D204Z520004"));
			d.setD204z520005((String) r.get("D204Z520005"));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");

			d.setD204z52Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			list.add(d);
		}
		d204z52Dao.batchInsert(list);
	}
	public void batchInsertFromTemp(ParameterSet pset) {
		// TODO Auto-generated method stub
		pset.setParameter("ifNopage", "1");
		DataSet ds = feedBackDao.queryCompareResultInfo(pset);
		List<D204z52> list = new ArrayList<D204z52>();
		String[] mainIds = new String[ds.getCount()];
		for(int i=0;i<ds.getCount();i++){
			Record r =ds.getRecord(i);
			mainIds[i]=(String)r.get("D204Z52_ID");
			D204z52 d = new D204z52();
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILYID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			d.setD204z520001((String) r.get("D204Z520001"));
			d.setD204z520002((String) r.get("D204Z520002"));
			d.setD204z520003(new BigDecimal(r.get("D204Z520003")+""));
			d.setD204z520004((String) r.get("D204Z520004"));
			d.setD204z520005((String) r.get("D204Z520005"));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");
			
			d.setD204z52Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			
			list.add(d);
		}
		d204z52Dao.batchInsert(list);
		d204z52TempDao.batchUpdateStatus(mainIds);
	}

}