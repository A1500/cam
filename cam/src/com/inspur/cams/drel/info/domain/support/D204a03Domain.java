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
import com.inspur.cams.drel.info.dao.ID204a03Dao;
import com.inspur.cams.drel.info.data.D204a03;
import com.inspur.cams.drel.info.data.D204c22;
import com.inspur.cams.drel.info.domain.ID204a03Domain;
import com.inspur.cams.drel.temp.dao.ID204a03TempDao;
import com.inspur.cams.drel.temp.dao.ID204c22TempDao;

/**
 * 家庭基本信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204a03Domain implements ID204a03Domain {

	@Reference
	private ID204a03Dao d204a03Dao;
	@Reference
	private IFeedBackDao feedBackDao;
	@Reference
	private ID204a03TempDao d204a03TempDao;
	/**
	 * 查询 家庭基本信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204a03Dao.query(pset);
	}

	/**
	 * 获取 家庭基本信息
	 * @param pset
	 * @return
	 */
	public D204a03 get(String familiyId) {
		return d204a03Dao.get(familiyId);
	}

	/**
	 * 增加 家庭基本信息
	 * @param d204a03
	 */
	public void insert(D204a03 d204a03) {
		d204a03.setFamiliyId(IdHelp.getUUID32());
		d204a03.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204a03.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204a03.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204a03.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204a03.setInputTime(DateUtil.getTime());
		d204a03Dao.insert(d204a03);
	}
	
	/**
	 * 修改 家庭基本信息
	 * @param d204a03
	 */
	public void update(D204a03 d204a03) {
		d204a03Dao.update(d204a03);
	}
	
	/**
	 * 删除 家庭基本信息
	 * @param familiyId
	 */
	public void delete(String familiyId) {
		d204a03Dao.delete(familiyId);
	}
	public void insertFromTemp(Record[] records){
		List<D204a03> list = new ArrayList<D204a03>();
		String[] mainIds = new String[records.length];
		for(int i=0;i<records.length;i++){
			Record r =records[i];
			mainIds[i]=(String)r.get("FAMILYID");
			D204a03 d = new D204a03();
			//d.setCommissionId((String)r.get("COMMID"));
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILYID"));
			d.setD204a030001((String)r.get("D204A030001"));
			d.setD204a030002((String)r.get("D204A030002"));
			d.setD204a030003((String)r.get("D204A030003"));
			d.setD204a030004((String)r.get("D204A030004"));
			d.setD204a030005((String)r.get("D204A030005"));
			d.setD204a030006((String)r.get("D204A030006"));
			d.setD204a030007((String)r.get("D204A030007"));
			d.setD204a030008("".equals(r.get("D204A030008"))?null:new BigDecimal(r.get("D204A030008")+""));
			d.setD204a030009((String)r.get("D204A030009"));
			d.setD204a030010((String)r.get("D204A030010"));
			d.setD204a030011((String)r.get("D204A030011"));
			d.setD204a030012("".equals(r.get("D204A030012"))?null:new BigDecimal(r.get("D204A030012")+""));
			d.setD204a030013("".equals(r.get("D204A030013"))?null:new BigDecimal(r.get("D204A030013")+""));
			d.setD204a030014("".equals(r.get("D204A030014"))?null:new BigDecimal(r.get("D204A030014")+""));
			d.setD204a030015("".equals(r.get("D204A030015"))?null:new BigDecimal(r.get("D204A030015")+""));
			d.setD204a030016("".equals(r.get("D204A030016"))?null:new BigDecimal(r.get("D204A030016")+""));
			d.setD204a030017("".equals(r.get("D204A030017"))?null:new BigDecimal(r.get("D204A030017")+""));
			d.setD204a030018((String)r.get("D204A030018"));
			d.setD204a030019((String)r.get("D204A030019"));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");
			
			//d.setD204a03Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			
			list.add(d);
		}
		d204a03Dao.batchInsert(list);
		d204a03TempDao.batchUpdateStatus(mainIds);
	}
	public void batchInsertFromTemp(ParameterSet pset) {
		// TODO Auto-generated method stub
		pset.setParameter("ifNopage", "1");
		DataSet ds = feedBackDao.queryCompareResultInfo(pset);
		List<D204a03> list = new ArrayList<D204a03>();
		String[] mainIds = new String[ds.getCount()];
		for(int i=0;i<ds.getCount();i++){
			Record r =ds.getRecord(i);
			mainIds[i]=(String)r.get("FAMILYID");
			D204a03 d = new D204a03();
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILYID"));
			d.setD204a030001((String)r.get("D204A030001"));
			d.setD204a030002((String)r.get("D204A030002"));
			d.setD204a030003((String)r.get("D204A030003"));
			d.setD204a030004((String)r.get("D204A030004"));
			d.setD204a030005((String)r.get("D204A030005"));
			d.setD204a030006((String)r.get("D204A030006"));
			d.setD204a030007((String)r.get("D204A030007"));
			d.setD204a030008(new BigDecimal(r.get("D204A030008")+""));
			d.setD204a030009((String)r.get("D204A030009"));
			d.setD204a030010((String)r.get("D204A030010"));
			d.setD204a030011((String)r.get("D204A030011"));
			d.setD204a030012(new BigDecimal(r.get("D204A030012")+""));
			d.setD204a030013(new BigDecimal(r.get("D204A030013")+""));
			d.setD204a030014(new BigDecimal(r.get("D204A030014")+""));
			d.setD204a030015(new BigDecimal(r.get("D204A030015")+""));
			d.setD204a030016(new BigDecimal(r.get("D204A030016")+""));
			d.setD204a030017(new BigDecimal(r.get("D204A030017")+""));
			d.setD204a030018((String)r.get("D204A030018"));
			d.setD204a030019((String)r.get("D204A030019"));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");
			
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			
			list.add(d);
		}
		d204a03Dao.batchInsert(list);
		d204a03TempDao.batchUpdateStatus(mainIds);
	}
}