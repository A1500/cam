package com.inspur.cams.prs.prsproblemdeal.domain;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.prs.prsattachment.dao.IPrsAttachmentDao;
import com.inspur.cams.prs.prsattachment.dao.PrsAttachment;
import com.inspur.cams.prs.prsproblemdeal.dao.IPrsProblemDealDao;
import com.inspur.cams.prs.prsproblemdeal.dao.PrsProblemDeal;
import com.inspur.cams.prs.prsproblemhistory.dao.IPrsProblemHistoryDao;
import com.inspur.cams.prs.prsproblemhistory.dao.PrsProblemHistory;


/**
 * @title:PrsProblemDealDomain
 * @description:问题处理信息管理
 * @author:jiangzhaobao
 * @since:2011年8月26日16:32:52
 * @version:1.0
*/
public class PrsProblemDealDomain implements IPrsProblemDealDomain{
	@Reference
	private IPrsProblemDealDao prsProblemDealDao;
	@Reference
	private IPrsProblemHistoryDao prsProblemHistoryDao;
	@Reference
	private IPrsAttachmentDao prsAttachmentDao;
	
	public void batchDelete(String[] delIds) {
		prsAttachmentDao.batchDeleteByPoliciesId(delIds);
		prsProblemDealDao.batchDelete(delIds);
	}

	public void insert(ParameterSet pset,MultipartRequestWrapper wrapRequest) {
		Record record=(Record)pset.getParameter("record");
		String receiveOrgan=(String)pset.getParameter("receiveOrgan");
		String receiveOrganName=(String)pset.getParameter("receiveOrganName");
		PrsProblemDeal bean=(PrsProblemDeal)record.toBean(PrsProblemDeal.class);
		bean.setProblemId(IdHelp.getUUID32());
		//录入人Id
		bean.setEntryPerson(BspUtil.getEmpOrganId());
		//录入人姓名
		bean.setEntryPersonName(BspUtil.getEmpOrgan().getOrganName());
		//登记机关
		bean.setOrgan(BspUtil.getCorpOrgan().getOrganCode());
		//登记机关名称
		bean.setOrganName(BspUtil.getCorpOrgan().getOrganName());
		
		//保存附件信息
		Map<String,UploadFile> map=wrapRequest.getUploadFiles();
		Set<Entry<String,UploadFile>> set=map.entrySet();
		Iterator<Entry<String,UploadFile>> iterator=set.iterator();
		UploadFile uploadfile=null;
		PrsAttachment attachment=null;
		// 用于存放所有附件的名字
		List<String> filenames=new ArrayList<String>();
		List<String> prefilenames=new ArrayList<String>();
		String filename=null;
		// 遍历Map，封装成PrsAttachment对象，并放入List中。
		List<PrsAttachment> list=new ArrayList<PrsAttachment>();
		while(iterator.hasNext()){
			uploadfile=iterator.next().getValue();
			if(uploadfile.getFileSize()>5*1024*1024){
				throw new RuntimeException(uploadfile.getFileName()+" 文件过大，上传文件不能超过5M！");
			}
			// 如果文件名相同，则只保存第一条，其余的放弃。
			filename=uploadfile.getFileName();
			if(filenames.contains(filename)){
				continue;
			}
			filenames.add(filename);
			prefilenames.add(filename);
			attachment=new PrsAttachment();
			attachment.setAttachmentId(IdHelp.getUUID32());
			attachment.setPoliciesRegulationsId(bean.getProblemId());
			attachment.setUploadtime(DateUtil.getDay());
			attachment.setFileName(uploadfile.getFileName());
			attachment.setAttachment(uploadfile);
			list.add(attachment);
		}
		prsAttachmentDao.batchInsert(list);	
		if(StringUtils.isNotEmpty(receiveOrgan)){
			bean.setReceiveorgan(receiveOrgan);
			bean.setReceiveorganName(receiveOrganName);
			bean.setSendTime(DateUtil.getDay());
			prsProblemDealDao.insert(bean);
			//问题处理历史信息表
			PrsProblemHistory historyBean=new PrsProblemHistory();
			historyBean.setProblemHistoryId(IdHelp.getUUID32());
			historyBean.setProblemId(bean.getProblemId());
			historyBean.setPersonNumber(bean.getPersonNumber());
			historyBean.setSendOrgan(bean.getOrgan());
			historyBean.setSendOrganName(bean.getOrganName());
			historyBean.setSendPerson(bean.getEntryPerson());
			historyBean.setSendPersonName(bean.getEntryPersonName());
			historyBean.setSendTime(bean.getSendTime());
			historyBean.setReceiveorgan(receiveOrgan);
			historyBean.setReceiveorganName(receiveOrganName);
			historyBean.setDealFlag("01");
			prsProblemHistoryDao.insert(historyBean);
		}else{
			prsProblemDealDao.insert(bean);
		}
		
	}

	public DataSet queryBySql(ParameterSet pset) {
		return prsProblemDealDao.queryBySql(pset);
	}
	public DataSet querySql(String problemId){
		DataSet ds = new DataSet();
		ds.addRecord(prsProblemDealDao.get(problemId));
		return ds;
	}
	public DataSet query(ParameterSet pset){
		return prsProblemDealDao.query(pset);
	}
	/**
	 * 办理
	 * @param bean
	 */
	public void process(ParameterSet pset) {
		Record record = (Record) pset.getParameter("record");
		String receiveOrgan = (String) pset.getParameter("receiveOrgan");
		String receiveOrganName = (String) pset
				.getParameter("receiveOrganName");
		String isEnd = (String) pset.getParameter("isEnd");
		String coutinue = (String) pset.getParameter("coutinue");
		PrsProblemDeal bean = (PrsProblemDeal) record
				.toBean(PrsProblemDeal.class);
		if (StringUtils.isNotEmpty(isEnd)) {
			// 上级转发过来的，现在办理完结
			bean.setCurActivity("02");
			prsProblemDealDao.update(bean);
			// 问题历史信息中处
			prsProblemHistoryDao.updateDealFlag(bean.getProblemId());
		} else {
			if (StringUtils.isNotEmpty(coutinue)) {
				bean.setReceiveorgan(receiveOrgan);
				bean.setReceiveorganName(receiveOrganName);
				bean.setSendTime(DateUtil.getDay());
				bean.setCurActivity("01");
				prsProblemDealDao.update(bean);

				// 问题处理历史信息表
				PrsProblemHistory historyBean = new PrsProblemHistory();
				historyBean.setProblemHistoryId(IdHelp.getUUID32());
				historyBean.setProblemId(bean.getProblemId());
				historyBean.setSendOrgan(BspUtil.getCorpOrgan().getOrganCode());
				historyBean.setSendOrganName(BspUtil.getCorpOrgan()
						.getOrganName());
				historyBean.setSendPerson(BspUtil.getEmpOrganId());
				historyBean.setPersonNumber(bean.getPersonNumber());
				historyBean.setSendPersonName(BspUtil.getEmpOrgan()
						.getOrganName());
				historyBean.setSendTime(DateUtil.getDay());
				historyBean.setReceiveorgan(receiveOrgan);
				historyBean.setReceiveorganName(receiveOrganName);
				historyBean.setDealFlag("01");
				prsProblemHistoryDao.insert(historyBean);
				// 修改此问题转发到本单位时的历史记录的处理状态
				ParameterSet historyPS = new ParameterSet();
				historyPS.setParameter("problem_Id", bean.getProblemId());
				historyPS.setParameter("receiveOrgan", BspUtil.getCorpOrgan()
						.getOrganCode());
				DataSet ds = prsProblemHistoryDao.query(historyPS);
				if (ds.getCount() != 0) {
					PrsProblemHistory hisBean = (PrsProblemHistory) ds
							.getRecord(0).toBean(PrsProblemHistory.class);
					hisBean.setDealFlag("02");
					prsProblemHistoryDao.update(hisBean);
				}

			} else {
				bean.setReceiveorgan(receiveOrgan);
				bean.setReceiveorganName(receiveOrganName);
				bean.setSendTime(DateUtil.getDay());
				bean.setCurActivity("01");
				prsProblemDealDao.update(bean);
				// 问题处理历史信息表
				PrsProblemHistory historyBean = new PrsProblemHistory();
				historyBean.setProblemHistoryId(IdHelp.getUUID32());
				historyBean.setProblemId(bean.getProblemId());
				historyBean.setSendOrgan(bean.getOrgan());
				historyBean.setPersonNumber(bean.getPersonNumber());
				historyBean.setSendOrganName(bean.getOrganName());
				historyBean.setSendPerson(bean.getEntryPerson());
				historyBean.setSendPersonName(bean.getEntryPersonName());
				historyBean.setSendTime(bean.getSendTime());
				historyBean.setReceiveorgan(receiveOrgan);
				historyBean.setReceiveorganName(receiveOrganName);
				historyBean.setDealFlag("01");
				prsProblemHistoryDao.insert(historyBean);
			}
		}
		
	}
	/**
	 * 更新问题处理
	 */
	public void update(ParameterSet pset,MultipartRequestWrapper wrapRequest){
		Record record=(Record)pset.getParameter("record");
		PrsProblemDeal bean=(PrsProblemDeal)record.toBean(PrsProblemDeal.class);
		String receiveOrgan=(String)pset.getParameter("receiveOrgan");
		String receiveOrganName=(String)pset.getParameter("receiveOrganName");
		
		//保存附件信息
		Map<String,UploadFile> map=wrapRequest.getUploadFiles();
		Set<Entry<String,UploadFile>> set=map.entrySet();
		Iterator<Entry<String,UploadFile>> iterator=set.iterator();
		UploadFile uploadfile=null;
		PrsAttachment attachment=null;
		// 用于存放所有附件的名字
		List<String> filenames=new ArrayList<String>();
		List<String> prefilenames=new ArrayList<String>();
		String filename=null;
		// 遍历Map，封装成PrsAttachment对象，并放入List中。
		List<PrsAttachment> list=new ArrayList<PrsAttachment>();
		while(iterator.hasNext()){
			uploadfile=iterator.next().getValue();
			if(uploadfile.getFileSize()>5*1024*1024){
				throw new RuntimeException(uploadfile.getFileName()+" 文件过大，上传文件不能超过5M！");
			}
			// 如果文件名相同，则只保存第一条，其余的放弃。
			filename=uploadfile.getFileName();
			if(filenames.contains(filename)){
				continue;
			}
			filenames.add(filename);
			prefilenames.add(filename);
			attachment=new PrsAttachment();
			attachment.setAttachmentId(IdHelp.getUUID32());
			attachment.setPoliciesRegulationsId(bean.getProblemId());
			attachment.setUploadtime(DateUtil.getDay());
			attachment.setFileName(uploadfile.getFileName());
			attachment.setAttachment(uploadfile);
			list.add(attachment);
		}
		prsAttachmentDao.batchInsert(list);
		
		if(StringUtils.isNotEmpty(receiveOrgan)){
			bean.setReceiveorgan(receiveOrgan);
			bean.setReceiveorganName(receiveOrganName);
			bean.setSendTime(DateUtil.getDay());

			prsProblemDealDao.update(bean);
			//问题处理历史信息表
			PrsProblemHistory historyBean=new PrsProblemHistory();
			historyBean.setProblemHistoryId(IdHelp.getUUID32());
			historyBean.setProblemId(bean.getProblemId());
			historyBean.setSendOrgan(bean.getOrgan());
			historyBean.setSendOrganName(bean.getOrganName());
			historyBean.setSendPerson(bean.getEntryPerson());
			historyBean.setSendPersonName(bean.getEntryPersonName());
			historyBean.setSendTime(bean.getSendTime());
			historyBean.setPersonNumber(bean.getPersonNumber());
			historyBean.setReceiveorgan(receiveOrgan);
			historyBean.setReceiveorganName(receiveOrganName);
			historyBean.setDealFlag("01");
			prsProblemHistoryDao.insert(historyBean);
		}else{
			prsProblemDealDao.update(bean);
		}
	}
}
