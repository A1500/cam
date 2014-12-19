package com.inspur.cams.dis.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.UploadFile;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dis.base.dao.IDisBaseFamilyRecordDao;
import com.inspur.cams.dis.base.dao.IDisReliefBatchDetailDao;
import com.inspur.cams.dis.base.dao.IDisReliefInfoDao;
import com.inspur.cams.dis.base.data.DisBaseFamilyRecord;
import com.inspur.cams.dis.base.data.DisReliefBatchDetail;
import com.inspur.cams.dis.base.data.DisReliefInfo;
import com.inspur.cams.dis.base.domain.IAssistanceDomain;
import com.inspur.cams.dis.base.domain.IDisPhotoDomain;

public class AssistanceDomain implements IAssistanceDomain{
	@Reference
	private IDisReliefInfoDao disReliefInfoDao;
	@Reference
	private IDisBaseFamilyRecordDao disBaseFamilyRecordDao;
	@Reference
	private IDisReliefBatchDetailDao disReliefBatchDetailDao;
	@Reference
	private IDisPhotoDomain photoDomain;
	public void save(ParameterSet pset, List<UploadFile> fileList){
		String method = (String)pset.getParameter("method");
		String organCode = (String)pset.getParameter("organCode");
		String organName = (String)pset.getParameter("organName");
		Record familyRecord = (Record)pset.getParameter("familyRecord");
		Record reliefRecord = (Record)pset.getParameter("reliefRecord");
		String batchDetailId = (String)pset.getParameter("batchDetailId");//批次明细ID
		List<DisReliefInfo> infoList = new ArrayList<DisReliefInfo>();
		DisReliefInfo infoBean = (DisReliefInfo)reliefRecord.toBean(DisReliefInfo.class);
		List<DisBaseFamilyRecord> familyList = new ArrayList<DisBaseFamilyRecord>();
		DisBaseFamilyRecord familyBean = (DisBaseFamilyRecord)familyRecord.toBean(DisBaseFamilyRecord.class);
		String infoId = "";
		List<String> delPicList = new ArrayList<String>();
		if("insert".equalsIgnoreCase(method)){//添加
			String recordId = IdHelp.getUUID32();//获得32位随机数
			infoId = IdHelp.getUUID32();    //获取新的主键
			String fillType = "0";//0:按户填报,1:整批填报(此处为添加方法，应该是按户填报)
			String fillTime = DateUtil.getTime();//获取当前时间给 填报时间fill_time字段
			String workflowStatus = "0";//流程跳转状态 0:录入保存 1:待审批（乡镇录入提交后） 2:待发放（审批同意提交后） 3:发放结束 4:审批不同意 5:待补齐补正
			String checkOrganCode = "";
			String checkOrganName = "";
			if(StringUtils.isNotEmpty(batchDetailId)){
				ParameterSet idPset = new ParameterSet();
				idPset.setParameter("BATCH_DETAIL_ID",batchDetailId);
				DataSet ds = disReliefBatchDetailDao.query(idPset);
				if(ds.getCount()>0){
					String reliefType = (String)ds.getRecord(0).get("reliefType");
					infoBean.setReliefType(reliefType);//设置 救助类型
					if("0".equals((String)ds.getRecord(0).get("fillState"))){//如果DisReliefBatchDetail表中填报状态是0，则改为1.（为县级修改用）
						Record newRecord = ds.getRecord(0);
						newRecord.set("fillState", "1");
						DisReliefBatchDetail detailBean = (DisReliefBatchDetail)newRecord.toBean(DisReliefBatchDetail.class);
						disReliefBatchDetailDao.update(detailBean);
					}
					checkOrganCode = (String)ds.getRecord(0).get("requiredOrganCode");//从DIS_RELIEF_BATCH_DETAIL表查询到的结果中获得乡镇（街道）区划
					checkOrganName = (String)ds.getRecord(0).get("requiredOrganName");//从DIS_RELIEF_BATCH_DETAIL表查询到的结果中获得乡镇（街道）名称
				}
			}
			infoBean.setRecordId(recordId);//设置 档案编号
			infoBean.setInfoId(infoId);//设置infoId（主键）
			infoBean.setOrganCode(organCode);//设置 填报单位代码
			infoBean.setOrganName(organName);//设置 填报单位名称
			infoBean.setBatchDetailId(batchDetailId);//设置 批次明细ID
			infoBean.setFillType(fillType);//设置 填报类型
			infoBean.setFillTime(fillTime);//设置 填报时间
			infoBean.setWorkflowStatus(workflowStatus);//设置 流程跳转状态
			infoBean.setCheckOrganCode(checkOrganCode);//设置 乡镇（街道）区划
			infoBean.setCheckOrganName(checkOrganName);//设置 乡镇（街道）名称
			if(organCode.endsWith("000")&&(!organCode.endsWith("000000"))){//乡镇级填报时 增加乡镇（街道）审核人名称，审核日期(10位)
				infoBean.setCheckPeopleName(GetBspInfo.getBspInfo().getUserName());//乡镇（街道）审核人名称
				infoBean.setCheckDate(DateUtil.getDay());//乡镇（街道）审核日期(10位)
			}
			
			familyBean.setRecordId(recordId);//设置recordId
			familyBean.setOrganCode(organCode);//设置organCode
			familyBean.setOrganName(organName);//设置organCode
			
		}else if("update".equalsIgnoreCase(method)){//修改
			infoId = infoBean.getInfoId();
			
			//删除图片
			String dPP = ((String) pset.getParameter("delPicPid"));
			if(StringUtils.isNotEmpty(dPP)){
				String[] delPicPids = ((String) pset.getParameter("delPicPid")).split(",");
				for(String delPid : delPicPids) {
					delPicList.add(delPid);
				}
			}
		}
		infoList.add(infoBean);
		familyList.add(familyBean);
		disReliefInfoDao.save(infoList);
		disBaseFamilyRecordDao.save(familyList);
		photoDomain.uploadDisPhoto(infoId,fileList);
		photoDomain.delete(delPicList);
	}
	/**
	 * 批量删除
	 */
	public void deleteBatch(ParameterSet pset){
		Record[] records = (Record[])pset.getParameter("records");//获得记录集
		String batchDetailId = (String)pset.getParameter("batchDetailId");//批次明细ID
		for(int i=0;i<records.length;i++){
			String recordId = (String)records[i].get("RECORD_ID");
			String infoId = (String)records[i].get("INFO_ID");
			disBaseFamilyRecordDao.delete(recordId);//先删除家庭信息表
			photoDomain.deleteInInfoId(infoId);//根据外键infoId删除所有与之相关的图片记录
			disReliefInfoDao.delete(infoId);//删除基本信息表
		}
		if(StringUtils.isNotEmpty(batchDetailId)){
			ParameterSet idPset = new ParameterSet();
			idPset.setParameter("BATCH_DETAIL_ID",batchDetailId);
			DataSet ds = disReliefInfoDao.query(idPset);
			if(ds.getCount()==0){//如果info表中数据都被删除，将detail表中状态改成“0”，以便县级可以修改
				DataSet detailDs = disReliefBatchDetailDao.query(idPset);
				if(detailDs.getCount()>0){
					Record newRecord = detailDs.getRecord(0);
					if(((String)newRecord.get("fillState")).equals("1")){
						newRecord.set("fillState", "0");
						newRecord.set("fillTime", "");
						newRecord.set("fillPeople", "");
						DisReliefBatchDetail detailBean = (DisReliefBatchDetail)newRecord.toBean(DisReliefBatchDetail.class);
						disReliefBatchDetailDao.update(detailBean);
					}
				}
			}
		}
	}
	/**
	 * 批量提交
	 */
	public void selectBatch(ParameterSet pset){
		String batchDetailId = (String)pset.getParameter("batchDetailId");//获得batchDetailId（批次明细表主键）
		if(StringUtils.isNotEmpty(batchDetailId)){
			disReliefInfoDao.selectBatch(batchDetailId);
			disReliefBatchDetailDao.selectBatch(batchDetailId);
		}
	}
}