package com.inspur.cams.dis.base.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dis.base.dao.IDisFundsSourceBatchDao;
import com.inspur.cams.dis.base.dao.IDisFundsSourceDao;
import com.inspur.cams.dis.base.dao.IDisFundsSourceDetailDao;
import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceBatch;
import com.inspur.cams.dis.base.data.DisFundsSourceDetail;
import com.inspur.cams.dis.base.domain.IDisFundsSourceBatchDomain;

/**
 * 资金拨付批次表domain
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceBatchDomain implements IDisFundsSourceBatchDomain {

	@Reference
	private IDisFundsSourceBatchDao disFundsSourceBatchDao;
	
	@Reference
	private IDisFundsSourceDao disFundsSourceDao;
	
	@Reference
	private IDisFundsSourceDetailDao disFundsSourceDetailDao;

	/**
	 * 查询 资金拨付批次表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return disFundsSourceBatchDao.query(pset);
	}

	/**
	 * 获取 资金拨付批次表
	 * @param pset
	 * @return
	 */
	public DisFundsSourceBatch get(String batchId) {
		return disFundsSourceBatchDao.get(batchId);
	}

	/**
	 * 增加 资金拨付批次表
	 * @param disFundsSourceBatch
	 */
	public void insert(DisFundsSourceBatch disFundsSourceBatch) {
		disFundsSourceBatchDao.insert(disFundsSourceBatch);
	}
	
	/**
	 * 修改 资金拨付批次表
	 * @param disFundsSourceBatch
	 */
	public void update(DisFundsSourceBatch disFundsSourceBatch) {
		disFundsSourceBatchDao.update(disFundsSourceBatch);
	}
	
	/**
	 * 删除 资金拨付批次表
	 * @param batchId
	 */
	public void delete(String batchId) {
		disFundsSourceBatchDao.delete(batchId);
	}

	/**
	 * 增加基本
	 */
	public void insertInit(DisFundsSourceBatch disFundsSourceBatch) {
		disFundsSourceBatchDao.insert(disFundsSourceBatch);
		if(disFundsSourceBatch.getDisFundsSourceList() != null &&
				disFundsSourceBatch.getDisFundsSourceList().size()>0) {
			disFundsSourceDao.batchInsert(disFundsSourceBatch.getDisFundsSourceList());
		}
	}
	
	/**
	 * 修改基本
	 */
	public void updateInit(DisFundsSourceBatch disFundsSourceBatch) {
		disFundsSourceBatchDao.update(disFundsSourceBatch);
		disFundsSourceDao.updateBase(disFundsSourceBatch);//同步基本信息至拨付表-同一批次
	}
	
	/**
	 * @Description: 拨付
	 * @author xuexzh
	 */
	public void allocation(ParameterSet parameterSet) {
		Record disFundsSourceRecord = (Record) parameterSet.get("disFundsSource");
		Record[] disFundsSourceOfCentralRecords = (Record[]) parameterSet.get("disFundsSourceOfCentrals");
		Record[] disFundsSourceOfDepartmentRecords = (Record[]) parameterSet.get("disFundsSourceOfDepartments");
		String organType = BspUtil.getOrganType();//当前登录人所属组织类型
		if(!"11".equals(organType) && !"12".equals(organType)) {
			//如果不是省级/市级，则异常退出
			throw new RuntimeException("未知登录人所属单位类型！");
		}
		
		DisFundsSource disFundsSource = (DisFundsSource) disFundsSourceRecord.toBean(DisFundsSource.class);
		disFundsSource.setFillOrganCode(BspUtil.getOrganCode());
		disFundsSource.setFillOrganName(BspUtil.getOrganName());
		disFundsSource.setUpdatePeopleName(GetBspInfo.getBspInfo().getUserName());
		disFundsSource.setUpdateTime(DateUtil.getTime());
		
		//关系数据的资金返还给源编码-重置关系数据
		disFundsSourceDao.resetRef(disFundsSource);
		
		//删除关系数据-至临时表
		disFundsSourceDao.deleteRef(disFundsSource);
		
		//生成新关系并生成源资金减值语句，并分资金等级计算和值
		BigDecimal zero = new BigDecimal(0);
		BigDecimal amountTotalOfCentral = new BigDecimal(0);
		BigDecimal meterialTotalOfCentral = new BigDecimal(0);
		
		BigDecimal amountTotalOfDepartment = new BigDecimal(0);
		BigDecimal meterialTotalOfDepartment = new BigDecimal(0);
		
		List<DisFundsSource> disFundsSourceOfSourceList = new ArrayList<DisFundsSource>(); //存放源数据
		List<DisFundsSource> disFundsSourceOfRefList = new ArrayList<DisFundsSource>();	//关系数据
		Set<Object> refMidSourceIdSet = new HashSet<Object>();	//存放中间数据的主键
		
		//中央
		if(disFundsSourceOfCentralRecords != null && disFundsSourceOfCentralRecords.length > 0) {
			for(int i=0; i<disFundsSourceOfCentralRecords.length; i++) {
				DisFundsSource disFundsSourceOfCentral = (DisFundsSource)disFundsSourceOfCentralRecords[i].toBean(DisFundsSource.class);
				if(zero.compareTo(disFundsSourceOfCentral.getAmountExtReal())!=0 || zero.compareTo(disFundsSourceOfCentral.getMeterialExtReal())!=0) {
					//如果实际计算资金/物资金额不为0，则生成关系数据
					DisFundsSource databean = new DisFundsSource();
					databean.setOldSourceId(disFundsSourceOfCentral.getSourceId());
					databean.setEndSourceId(disFundsSource.getSourceId());
					
					databean.setOldUpAllocationNum(disFundsSourceOfCentral.getUpAllocationNum());
					databean.setOldUpAllocationPurpose(disFundsSourceOfCentral.getUpAllocationPurpose());
					databean.setOldUpAllocationType(disFundsSourceOfCentral.getUpAllocationType());
					if("11".equals(organType)) {
						//省
						databean.setOldFundsType(disFundsSourceOfCentral.getFundsType());
					}else if("12".equals(organType)) {
						//市
						databean.setOldFundsType(disFundsSourceOfCentral.getOldFundsType());
						databean.setMidUpAllocationNum(disFundsSourceOfCentral.getUpAllocationNum());
						StringBuffer group = new StringBuffer();
						group.append(disFundsSourceOfCentral.getOldSourceId()).append("!");
						group.append(disFundsSourceOfCentral.getDisYear()).append("!");
						group.append(disFundsSourceOfCentral.getUpAllocationPurpose()).append("!");
						group.append(disFundsSourceOfCentral.getUpAllocationType()).append("!");
						group.append(disFundsSourceOfCentral.getFundsType());
						databean.setMidUpAllocationNumNext(group.toString());
					}
					databean.setReceiveOrganCode(disFundsSource.getReceiveOrganCode());
					databean.setReceiveOrganName(disFundsSource.getReceiveOrganName());
					databean.setFillOrganCode(disFundsSource.getFillOrganCode());
					databean.setFillOrganName(disFundsSource.getFillOrganName());
					databean.setFillPeopleName(disFundsSource.getUpdatePeopleName());
					databean.setFillTime(disFundsSource.getUpdateTime());
					databean.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
					databean.setUpdateTime(disFundsSource.getUpdateTime());


					databean.setAmountTotal(disFundsSourceOfCentral.getAmountExtReal().add(disFundsSourceOfCentral.getMeterialExtReal()));
					databean.setAmount(disFundsSourceOfCentral.getAmountExtReal());
					databean.setMeterial(disFundsSourceOfCentral.getMeterialExtReal());
					databean.setAmountBalance(disFundsSourceOfCentral.getAmountExtReal());
					databean.setMeterialBalance(disFundsSourceOfCentral.getMeterialExtReal());
					
					databean.setAmountTotalCentral(zero);
					databean.setAmountTotalDepartment(zero);
					databean.setAmountTotalCity(zero);
					databean.setAmountCity(zero);
					databean.setMeterialCity(zero);
					databean.setAmountTotalCounty(zero);
					databean.setAmountCounty(zero);
					databean.setMeterialCounty(zero);
					
					databean.setSourceId(IdHelp.getUUID32());
					databean.setBatchId(disFundsSource.getBatchId());
					databean.setDisYear(disFundsSource.getDisYear());
					databean.setSourceType(disFundsSource.getSourceType());
					databean.setUpAllocationNum(disFundsSource.getUpAllocationNum());
					databean.setUpAllocationType(disFundsSource.getUpAllocationType());
					databean.setUpAllocationPurpose(disFundsSource.getUpAllocationPurpose());
					
					databean.setInRef("1");
					databean.setInUse("9");
					databean.setFundsType(disFundsSource.getFundsType());
					databean.setState(Record.STATE_NEW);
					//计算和值
					amountTotalOfCentral = amountTotalOfCentral.add(disFundsSourceOfCentral.getAmountExtReal());
					meterialTotalOfCentral = meterialTotalOfCentral.add(disFundsSourceOfCentral.getMeterialExtReal());
					
					disFundsSourceOfCentral.setAmountBalance(disFundsSourceOfCentral.getAmountExtTotal().subtract(disFundsSourceOfCentral.getAmountExtReal()));
					disFundsSourceOfCentral.setMeterialBalance(disFundsSourceOfCentral.getMeterialExtTotal().subtract(disFundsSourceOfCentral.getMeterialExtReal()));
					disFundsSourceOfCentral.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
					disFundsSourceOfCentral.setUpdateTime(disFundsSource.getUpdateTime());
					disFundsSourceOfCentral.setInUse("1");
					disFundsSourceOfCentral.setState(Record.STATE_MODIFIED);
					
					refMidSourceIdSet.add(disFundsSourceOfCentral.getOldSourceId());
					disFundsSourceOfRefList.add(databean);
					disFundsSourceOfSourceList.add(disFundsSourceOfCentral);
				}
			}
		}
		//省
		if(disFundsSourceOfDepartmentRecords != null && disFundsSourceOfDepartmentRecords.length > 0) {
			for(int i=0; i<disFundsSourceOfDepartmentRecords.length; i++) {
				DisFundsSource disFundsSourceOfDepartment = (DisFundsSource)disFundsSourceOfDepartmentRecords[i].toBean(DisFundsSource.class);
				if(zero.compareTo(disFundsSourceOfDepartment.getAmountExtReal())!=0 || zero.compareTo(disFundsSourceOfDepartment.getMeterialExtReal())!=0) {
					//如果实际计算资金/物资金额不为0，则生成关系数据
					DisFundsSource databean = new DisFundsSource();
					databean.setOldSourceId(disFundsSourceOfDepartment.getSourceId());
					databean.setEndSourceId(disFundsSource.getSourceId());
					
					databean.setOldUpAllocationNum(disFundsSourceOfDepartment.getUpAllocationNum());
					databean.setOldUpAllocationPurpose(disFundsSourceOfDepartment.getUpAllocationPurpose());
					databean.setOldUpAllocationType(disFundsSourceOfDepartment.getUpAllocationType());
					if("11".equals(organType)) {
						//省
						databean.setOldFundsType(disFundsSourceOfDepartment.getFundsType());
					}else if("12".equals(organType)) {
						//市
						databean.setOldFundsType(disFundsSourceOfDepartment.getOldFundsType());
						databean.setMidUpAllocationNum(disFundsSourceOfDepartment.getUpAllocationNum());
						StringBuffer group = new StringBuffer();
						group.append(disFundsSourceOfDepartment.getOldSourceId()).append("!");
						group.append(disFundsSourceOfDepartment.getDisYear()).append("!");
						group.append(disFundsSourceOfDepartment.getUpAllocationPurpose()).append("!");
						group.append(disFundsSourceOfDepartment.getUpAllocationType()).append("!");
						group.append(disFundsSourceOfDepartment.getFundsType());
						databean.setMidUpAllocationNumNext(group.toString());
					}
					databean.setReceiveOrganCode(disFundsSource.getReceiveOrganCode());
					databean.setReceiveOrganName(disFundsSource.getReceiveOrganName());
					databean.setFillOrganCode(disFundsSource.getFillOrganCode());
					databean.setFillOrganName(disFundsSource.getFillOrganName());
					databean.setFillPeopleName(disFundsSource.getUpdatePeopleName());
					databean.setFillTime(disFundsSource.getUpdateTime());
					databean.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
					databean.setUpdateTime(disFundsSource.getUpdateTime());

					databean.setAmountTotal(disFundsSourceOfDepartment.getAmountExtReal().add(disFundsSourceOfDepartment.getMeterialExtReal()));
					databean.setAmount(disFundsSourceOfDepartment.getAmountExtReal());
					databean.setMeterial(disFundsSourceOfDepartment.getMeterialExtReal());
					databean.setAmountBalance(disFundsSourceOfDepartment.getAmountExtReal());
					databean.setMeterialBalance(disFundsSourceOfDepartment.getMeterialExtReal());
					
					databean.setAmountTotalCentral(zero);
					databean.setAmountTotalDepartment(zero);
					databean.setAmountTotalCity(zero);
					databean.setAmountCity(zero);
					databean.setMeterialCity(zero);
					databean.setAmountTotalCounty(zero);
					databean.setAmountCounty(zero);
					databean.setMeterialCounty(zero);
					
					databean.setSourceId(IdHelp.getUUID32());
					databean.setBatchId(disFundsSource.getBatchId());
					databean.setDisYear(disFundsSource.getDisYear());
					databean.setSourceType(disFundsSource.getSourceType());
					databean.setUpAllocationNum(disFundsSource.getUpAllocationNum());
					databean.setUpAllocationType(disFundsSource.getUpAllocationType());
					databean.setUpAllocationPurpose(disFundsSource.getUpAllocationPurpose());
					
					databean.setInRef("1");
					databean.setInUse("9");
					databean.setFundsType(disFundsSource.getFundsType());
					databean.setState(Record.STATE_NEW);
					//计算和值
					amountTotalOfDepartment = amountTotalOfDepartment.add(disFundsSourceOfDepartment.getAmountExtReal());
					meterialTotalOfDepartment = meterialTotalOfDepartment.add(disFundsSourceOfDepartment.getMeterialExtReal());
					
					disFundsSourceOfDepartment.setAmountBalance(disFundsSourceOfDepartment.getAmountExtTotal().subtract(disFundsSourceOfDepartment.getAmountExtReal()));
					disFundsSourceOfDepartment.setMeterialBalance(disFundsSourceOfDepartment.getMeterialExtTotal().subtract(disFundsSourceOfDepartment.getMeterialExtReal()));
					disFundsSourceOfDepartment.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
					disFundsSourceOfDepartment.setUpdateTime(disFundsSource.getUpdateTime());
					disFundsSourceOfDepartment.setInUse("1");
					disFundsSourceOfDepartment.setState(Record.STATE_MODIFIED);

					refMidSourceIdSet.add(disFundsSourceOfDepartment.getOldSourceId());
					disFundsSourceOfRefList.add(databean);
					disFundsSourceOfSourceList.add(disFundsSourceOfDepartment);
				}
			}
		}

		//封装数据至单条汇总，保存单条
		disFundsSource.setAmountTotalCentral(amountTotalOfCentral.add(meterialTotalOfCentral));
		disFundsSource.setAmountTotalDepartment(amountTotalOfDepartment.add(meterialTotalOfDepartment));

		BigDecimal amount = amountTotalOfCentral.add(amountTotalOfDepartment);
		BigDecimal meterial = meterialTotalOfCentral.add(meterialTotalOfDepartment);
		if("12".equals(organType)) {
			// 如果为市级，则总和需要追加市级款
			if (disFundsSource.getAmountCity() != null)
				amount = amount.add(disFundsSource.getAmountCity());
			if (disFundsSource.getMeterialCity() != null)
				meterial = meterial.add(disFundsSource.getMeterialCity());
		}
		disFundsSource.setAmountTotal(amount.add(meterial));
		disFundsSource.setAmount(amount);
		disFundsSource.setMeterial(meterial);
		disFundsSource.setAmountBalance(amount);
		disFundsSource.setMeterialBalance(meterial);
		disFundsSource.setState(Record.STATE_MODIFIED);
		
		disFundsSourceDao.update(disFundsSource);
		disFundsSourceDao.save(disFundsSourceOfSourceList);
		disFundsSourceDao.save(disFundsSourceOfRefList);
		
		if("12".equals(organType)) {
			//如果是市级，需要重新计算中间数据
			disFundsSourceDao.reComputeMid(refMidSourceIdSet);
		}
		
		//重新计算批次信息
		DisFundsSourceBatch disFundsSourceBatch = new DisFundsSourceBatch();
		disFundsSourceBatch.setBatchId(disFundsSource.getBatchId());
		disFundsSourceBatch.setFillOrganCode(disFundsSource.getFillOrganCode());
		disFundsSourceBatch.setFillOrganName(disFundsSource.getFillOrganName());
		disFundsSourceBatch.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
		disFundsSourceBatch.setUpdateTime(disFundsSource.getUpdateTime());
		disFundsSourceBatchDao.reCompute(disFundsSourceBatch);
	}

	/**
	 * @Description: 拨付-市县
	 * @author xuexzh
	 */
	public void allocationSingle(ParameterSet parameterSet) {
		String batchId = (String) parameterSet.get("batchId");
		String actionFundsType = (String) parameterSet.get("actionFundsType");
		String currentSourceId = (String) parameterSet.get("currentSourceId");
		Record oldDisFundsSourceRecord = (Record) parameterSet.get("oldDisFundsSource");
		Record[] oldDisFundsSourceDetailDs = (Record[]) parameterSet.get("oldDisFundsSourceDetailDs");

		String organType = BspUtil.getOrganType();//当前登录人所属组织类型
		if(!"12".equals(organType) && !"13".equals(organType)) {
			//如果不是市级/县级，则异常退出
			throw new RuntimeException("未知登录人所属单位类型(非市/县级用户)！");
		}
		//获取目标信息
		ParameterSet pset = new ParameterSet();
		pset.put("SOURCE_ID", currentSourceId);
		DataSet ds = disFundsSourceDao.query(pset);
		
		DisFundsSource disFundsSource;
		if(ds.getCount()==1) {
			disFundsSource = (DisFundsSource)ds.getRecord(0).toBean(DisFundsSource.class);
		}else {
			throw new RuntimeException("无源数据！");
		}
		disFundsSource.setFillOrganCode(BspUtil.getOrganCode());
		disFundsSource.setFillOrganName(BspUtil.getOrganName());
		disFundsSource.setUpdatePeopleName(GetBspInfo.getBspInfo().getUserName());
		disFundsSource.setUpdateTime(DateUtil.getTime());
		
		//封装源信息
		DisFundsSource oldDisFundsSource = (DisFundsSource) oldDisFundsSourceRecord.toBean(DisFundsSource.class);
		oldDisFundsSource.setFillOrganCode(disFundsSource.getFillOrganCode());
		oldDisFundsSource.setFillOrganName(disFundsSource.getFillOrganName());
		oldDisFundsSource.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
		oldDisFundsSource.setUpdateTime(disFundsSource.getUpdateTime());
		
		//关系数据的资金返还给源编码-重置关系数据-根据源数据
		disFundsSourceDetailDao.resetRefByOld(oldDisFundsSourceDetailDs, disFundsSource);
		disFundsSourceDao.resetRefByOld(oldDisFundsSource, disFundsSource);
		
		//删除关系数据-至临时表-根据源数据
		disFundsSourceDetailDao.deleteRefByOld(oldDisFundsSourceDetailDs, disFundsSource);
		disFundsSourceDao.deleteRefByOld(oldDisFundsSource, disFundsSource);
		
		//生成新关系并生成源资金减值语句，并分资金等级计算和值
		BigDecimal zero = new BigDecimal(0);
		BigDecimal meterialTotal= new BigDecimal(0);
		
		List<DisFundsSourceDetail> disFundsSourceDetailOfSourceList = new ArrayList<DisFundsSourceDetail>(); //存放源明细
		List<DisFundsSourceDetail> disFundsSourceDetailOfRefList = new ArrayList<DisFundsSourceDetail>();	//关系明细
		
		//明细关系
		if(oldDisFundsSourceDetailDs != null && oldDisFundsSourceDetailDs.length > 0) {
			for(int i=0; i<oldDisFundsSourceDetailDs.length; i++) {
				DisFundsSourceDetail disFundsSourceDetail = (DisFundsSourceDetail)oldDisFundsSourceDetailDs[i].toBean(DisFundsSourceDetail.class);
				if(zero.compareTo(disFundsSourceDetail.getRealMeterialNum())!=0 || zero.compareTo(disFundsSourceDetail.getRealMeterialAccount())!=0) {
					//如果实际计算资金/物资金额不为0，则生成关系数据
					DisFundsSourceDetail databean = new DisFundsSourceDetail();
					databean.setSourceId(disFundsSource.getSourceId());
					databean.setOldAllocationDetailId(disFundsSourceDetail.getAllocationDetailId());
					databean.setBatchId(batchId);
					
					StringBuffer group = new StringBuffer();
					group.append(databean.getAllocationType()).append("!");
					databean.setOldAllocationDetail(group.toString());
					databean.setAllocationType(disFundsSource.getSourceType());
					
					databean.setMeterialType(disFundsSourceDetail.getMeterialType());
					databean.setMeterialNumBalance(disFundsSourceDetail.getMeterialNumBalance());
					databean.setMeterialUnit(disFundsSourceDetail.getMeterialUnit());
					
					databean.setMeterialNum(disFundsSourceDetail.getRealMeterialNum());
					databean.setMeterialNumBalance(disFundsSourceDetail.getRealMeterialNum());
					databean.setMeterialAccount(disFundsSourceDetail.getRealMeterialAccount());
					databean.setMeterialAccountBalance(disFundsSourceDetail.getRealMeterialAccount());
					
					databean.setFundsType(disFundsSource.getFundsType());
					databean.setAllocationDetailId(IdHelp.getUUID32());
					databean.setInRef("1");
					databean.setInUse("9");
					databean.setState(Record.STATE_NEW);
					//计算和值
					meterialTotal = meterialTotal.add(disFundsSourceDetail.getRealMeterialAccount());
					
					disFundsSourceDetail.setMeterialNumBalance(disFundsSourceDetail.getRealMeterialNumTotal().subtract(disFundsSourceDetail.getRealMeterialNum()));
					disFundsSourceDetail.setMeterialAccountBalance(disFundsSourceDetail.getRealMeterialAccountTotal().subtract(disFundsSourceDetail.getRealMeterialAccount()));
					disFundsSourceDetail.setInUse("1");
					disFundsSourceDetail.setState(Record.STATE_MODIFIED);
					
					disFundsSourceDetailOfRefList.add(databean);
					disFundsSourceDetailOfSourceList.add(disFundsSourceDetail);
				}
			}
		}
		
		//源关系
		DisFundsSource oldDisFundsSourceRef = new DisFundsSource();
		oldDisFundsSourceRef.setBatchId(disFundsSource.getBatchId());
		oldDisFundsSourceRef.setEndSourceId(disFundsSource.getSourceId());
		oldDisFundsSourceRef.setOldSourceId(oldDisFundsSource.getSourceId());
		if("13".equals(organType) && actionFundsType.equals("2")) {
			//如果为县级，并且此次操作的是市款，需要重置源款项等级为2-市级
			oldDisFundsSourceRef.setOldFundsType("2");
		}else {
			oldDisFundsSourceRef.setOldFundsType(oldDisFundsSource.getFundsType());
		}
		oldDisFundsSourceRef.setOldUpAllocationNum(oldDisFundsSource.getUpAllocationNum());
		oldDisFundsSourceRef.setOldUpAllocationPurpose(oldDisFundsSource.getUpAllocationPurpose());
		oldDisFundsSourceRef.setOldUpAllocationType(oldDisFundsSource.getUpAllocationType());
		oldDisFundsSourceRef.setMidUpAllocationNum(oldDisFundsSource.getMidUpAllocationNum());
		oldDisFundsSourceRef.setMidUpAllocationNumNext(oldDisFundsSource.getMidUpAllocationNumNext());

		oldDisFundsSourceRef.setDisYear(disFundsSource.getDisYear());
		oldDisFundsSourceRef.setSourceType("0");
		oldDisFundsSourceRef.setUpAllocationNum(disFundsSource.getUpAllocationNum());
		oldDisFundsSourceRef.setUpAllocationPurpose(disFundsSource.getUpAllocationPurpose());
		oldDisFundsSourceRef.setUpAllocationType(disFundsSource.getUpAllocationType());
		
		oldDisFundsSourceRef.setReceiveOrganCode(disFundsSource.getReceiveOrganCode());
		oldDisFundsSourceRef.setReceiveOrganName(disFundsSource.getReceiveOrganName());
		oldDisFundsSourceRef.setFillOrganCode(disFundsSource.getFillOrganCode());
		oldDisFundsSourceRef.setFillOrganName(disFundsSource.getFillOrganName());
		oldDisFundsSourceRef.setFillPeopleName(disFundsSource.getUpdatePeopleName());
		oldDisFundsSourceRef.setFillTime(disFundsSource.getUpdateTime());
		oldDisFundsSourceRef.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
		oldDisFundsSourceRef.setUpdateTime(disFundsSource.getUpdateTime());
		
		oldDisFundsSourceRef.setAmountTotal(meterialTotal.add(oldDisFundsSource.getAmountExtReal()));
		oldDisFundsSourceRef.setAmount(oldDisFundsSource.getAmountExtReal());
		oldDisFundsSourceRef.setMeterial(meterialTotal);
		oldDisFundsSourceRef.setAmountBalance(oldDisFundsSource.getAmountExtReal());
		oldDisFundsSourceRef.setMeterialBalance(meterialTotal);
		oldDisFundsSourceRef.setAmountTotalCentral(zero);
		oldDisFundsSourceRef.setAmountTotalDepartment(zero);
		oldDisFundsSourceRef.setAmountTotalCity(zero);
		oldDisFundsSourceRef.setAmountCity(zero);
		oldDisFundsSourceRef.setMeterialCity(zero);
		oldDisFundsSourceRef.setAmountTotalCounty(zero);
		oldDisFundsSourceRef.setAmountCounty(zero);
		oldDisFundsSourceRef.setMeterialCounty(zero);
		
		oldDisFundsSourceRef.setFundsType(disFundsSource.getFundsType());
		oldDisFundsSourceRef.setInRef("1");
		oldDisFundsSourceRef.setInUse("9");
		oldDisFundsSourceRef.setSourceId(IdHelp.getUUID32());
		oldDisFundsSourceRef.setState(Record.STATE_NEW);

		//封装源数据
		oldDisFundsSource.setAmountBalance(oldDisFundsSource.getAmountExtTotal().subtract(oldDisFundsSource.getAmountExtReal()));
		oldDisFundsSource.setMeterialBalance(oldDisFundsSource.getMeterialExtTotal().subtract(meterialTotal));
		oldDisFundsSource.setState(Record.STATE_MODIFIED);
		
		disFundsSourceDao.update(oldDisFundsSource);
		disFundsSourceDao.insert(oldDisFundsSourceRef);
		disFundsSourceDetailDao.save(disFundsSourceDetailOfSourceList);
		disFundsSourceDetailDao.save(disFundsSourceDetailOfRefList);
		
		//重新计算本条
		disFundsSourceDao.reCompute(disFundsSource, actionFundsType);
		
		//重新计算批次信息
		DisFundsSourceBatch disFundsSourceBatch = new DisFundsSourceBatch();
		disFundsSourceBatch.setBatchId(disFundsSource.getBatchId());
		disFundsSourceBatch.setFillOrganCode(disFundsSource.getFillOrganCode());
		disFundsSourceBatch.setFillOrganName(disFundsSource.getFillOrganName());
		disFundsSourceBatch.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
		disFundsSourceBatch.setUpdateTime(disFundsSource.getUpdateTime());
		disFundsSourceBatchDao.reCompute(disFundsSourceBatch);
	}
	
	/**
	 * @Description: 确认拨付
	 * @author xuexzh
	 */
	public void confirmAllocation(DisFundsSourceBatch disFundsSourceBatch) {
		disFundsSourceBatchDao.confirmAllocation(disFundsSourceBatch);
		disFundsSourceDao.confirmAllocation(disFundsSourceBatch);
		disFundsSourceDetailDao.confirmAllocation(disFundsSourceBatch);
		
		//重新计算批次信息
		disFundsSourceBatchDao.reCompute(disFundsSourceBatch);
		
		//确认后，验证数据
		disFundsSourceBatchDao.validateData(disFundsSourceBatch);
	}
	
	/**
	 * @Description: 删除批次
	 * @author xuexzh
	 */
	public void deleteAllocation(DisFundsSourceBatch disFundsSourceBatch) {
		disFundsSourceDetailDao.deleteAllocation(disFundsSourceBatch);
		disFundsSourceDao.deleteAllocation(disFundsSourceBatch);
		disFundsSourceBatchDao.deleteAllocation(disFundsSourceBatch);
	}
	
	/**
	 * @Description: 置换物资
	 * @author xuexzh
	 */
	public void swapMeterial(ParameterSet parameterSet) {
		String organType = BspUtil.getOrganType();
		String action = (String) parameterSet.get("action");
		Record disFundsSourceRecord = (Record) parameterSet.get("disFundsSource");
		Record[] oldDisFundsSourceRecords = (Record[]) parameterSet.get("oldDisFundsSources");
		Record[] disFundsSourceDetailRecords = (Record[]) parameterSet.get("disFundsSourceDetails");
		
		DisFundsSource disFundsSource = (DisFundsSource) disFundsSourceRecord.toBean(DisFundsSource.class);
		disFundsSource.setUpdatePeopleName(GetBspInfo.getBspInfo().getUserName());
		disFundsSource.setUpdateTime(DateUtil.getTime());
		
		BigDecimal sums = new BigDecimal(0.0);
		BigDecimal zero = new BigDecimal(0.0);
		List<DisFundsSourceDetail> disFundsSourceDetailsList = new ArrayList<DisFundsSourceDetail>();
		if(disFundsSourceDetailRecords!=null && disFundsSourceDetailRecords.length > 0) {
			for(int i=0;i<disFundsSourceDetailRecords.length;i++) {
				DisFundsSourceDetail disFundsSourceDetail = (DisFundsSourceDetail) disFundsSourceDetailRecords[i].toBean(DisFundsSourceDetail.class);
				disFundsSourceDetail.setAllocationDetailId(IdHelp.getUUID32());
				disFundsSourceDetail.setMeterialNumBalance(disFundsSourceDetail.getMeterialNum());
				disFundsSourceDetail.setMeterialAccountBalance(disFundsSourceDetail.getMeterialAccount());
				disFundsSourceDetail.setState(Record.STATE_NEW);
				sums = sums.add(disFundsSourceDetail.getMeterialAccount());
				disFundsSourceDetailsList.add(disFundsSourceDetail);
			}
		}
		disFundsSource.setAmount(zero);
		disFundsSource.setMeterial(sums);
		disFundsSource.setAmountTotal(sums);
		disFundsSource.setAmountBalance(zero);
		disFundsSource.setMeterialBalance(sums);
		if("12".equals(organType)) {
			//市级
			disFundsSource.setAmountTotalCity(sums);
			disFundsSource.setAmountCity(zero);
			disFundsSource.setMeterialCity(sums);
		}else if("13".equals(organType)) {
			//县级
			disFundsSource.setAmountTotalCounty(sums);
			disFundsSource.setAmountCounty(zero);
			disFundsSource.setMeterialCounty(sums);
		}else {
			throw new RuntimeException("未知登录等级");
		}
		

		BigDecimal sumsOfRef = new BigDecimal(0.0);
		List<DisFundsSource> disFundsSourceOfSourceList = new ArrayList<DisFundsSource>(); //存放源数据
		List<DisFundsSource> disFundsSourceOfRefList = new ArrayList<DisFundsSource>();	//关系数据
		
		if(oldDisFundsSourceRecords != null && oldDisFundsSourceRecords.length > 0) {
			for(int i=0; i<oldDisFundsSourceRecords.length; i++) {
				DisFundsSource disFundsSourceOfSwap = (DisFundsSource)oldDisFundsSourceRecords[i].toBean(DisFundsSource.class);
				if(zero.compareTo(disFundsSourceOfSwap.getAmountExtReal())!=0) {
					//如果实际计算资金不为0，则生成关系数据
					DisFundsSource databean = new DisFundsSource();
					databean.setOldSourceId(disFundsSourceOfSwap.getSourceId());
					databean.setEndSourceId(disFundsSource.getSourceId());
					
					databean.setOldUpAllocationNum(disFundsSourceOfSwap.getUpAllocationNum());
					databean.setOldUpAllocationPurpose(disFundsSourceOfSwap.getUpAllocationPurpose());
					databean.setOldUpAllocationType(disFundsSourceOfSwap.getUpAllocationType());
					databean.setOldFundsType(disFundsSourceOfSwap.getFundsType());

					databean.setReceiveOrganCode(disFundsSource.getReceiveOrganCode());
					databean.setReceiveOrganName(disFundsSource.getReceiveOrganName());
					databean.setFillOrganCode(disFundsSource.getFillOrganCode());
					databean.setFillOrganName(disFundsSource.getFillOrganName());
					databean.setFillPeopleName(disFundsSource.getUpdatePeopleName());
					databean.setFillTime(disFundsSource.getUpdateTime());
					databean.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
					databean.setUpdateTime(disFundsSource.getUpdateTime());

					databean.setAmountTotal(disFundsSourceOfSwap.getAmountExtReal());
					databean.setAmount(disFundsSourceOfSwap.getAmountExtReal());
					databean.setMeterial(zero);
					databean.setAmountBalance(disFundsSourceOfSwap.getAmountExtReal());
					databean.setMeterialBalance(zero);
					
					databean.setAmountTotalCentral(zero);
					databean.setAmountTotalDepartment(zero);
					databean.setAmountTotalCity(zero);
					databean.setAmountCity(zero);
					databean.setMeterialCity(zero);
					databean.setAmountTotalCounty(zero);
					databean.setAmountCounty(zero);
					databean.setMeterialCounty(zero);
					
					databean.setSourceId(IdHelp.getUUID32());
					//databean.setBatchId(disFundsSource.getBatchId());
					databean.setDisYear(disFundsSource.getDisYear());
					databean.setSourceType(disFundsSource.getSourceType());
					databean.setUpAllocationNum(disFundsSource.getUpAllocationNum());
					databean.setUpAllocationType(disFundsSource.getUpAllocationType());
					databean.setUpAllocationPurpose(disFundsSource.getUpAllocationPurpose());
					
					databean.setInRef("1");
					databean.setInUse("0");
					databean.setFundsType(disFundsSource.getFundsType());
					databean.setState(Record.STATE_NEW);
					//计算和值
					sumsOfRef = sumsOfRef.add(disFundsSourceOfSwap.getAmountExtReal());
					
					disFundsSourceOfSwap.setAmountBalance(disFundsSourceOfSwap.getAmountExtTotal().subtract(disFundsSourceOfSwap.getAmountExtReal()));
					disFundsSourceOfSwap.setUpdatePeopleName(disFundsSource.getUpdatePeopleName());
					disFundsSourceOfSwap.setUpdateTime(disFundsSource.getUpdateTime());
					disFundsSourceOfSwap.setInUse("1");
					disFundsSourceOfSwap.setState(Record.STATE_MODIFIED);

					disFundsSourceOfRefList.add(databean);
					disFundsSourceOfSourceList.add(disFundsSourceOfSwap);
				}
			}
		}
		
		if(sums.compareTo(sumsOfRef) != 0) {
			throw new RuntimeException("拨付与置换的金额不同");
		}
		
		if("insert".equals(action)) {
			disFundsSource.setFillPeopleName(disFundsSource.getUpdatePeopleName());
			disFundsSource.setFillTime(disFundsSource.getUpdateTime());
			disFundsSource.setState(Record.STATE_NEW);
			
			//更新源和插入新关系
			disFundsSourceDao.save(disFundsSourceOfSourceList);
			disFundsSourceDao.save(disFundsSourceOfRefList);
			
			//更新主记录相关
			disFundsSourceDao.insert(disFundsSource);
			disFundsSourceDetailDao.batchInsert(disFundsSourceDetailsList);
		}else if("update".equals(action)) {
			disFundsSource.setState(Record.STATE_MODIFIED);
			//先验证是否已使用
			boolean isUse = disFundsSourceDao.validateIsUse(disFundsSource);
			if(isUse) {
				throw new RuntimeException("已使用不能修改/删除");
			}
			//重置并删除源关系
			//--关系数据的资金返还给源编码-重置关系数据
			disFundsSourceDao.resetRefBySwap(disFundsSource);
			//--删除关系数据-至临时表
			disFundsSourceDao.deleteRefBySwap(disFundsSource);
			//--删除所有相关明细
			disFundsSourceDetailDao.deleteByRef(disFundsSource.getSourceId());
			
			//更新源和插入新关系
			disFundsSourceDao.save(disFundsSourceOfSourceList);
			disFundsSourceDao.save(disFundsSourceOfRefList);
			
			//更新主记录相关
			disFundsSourceDao.update(disFundsSource);
			disFundsSourceDetailDao.batchInsert(disFundsSourceDetailsList);
		}
	}
}