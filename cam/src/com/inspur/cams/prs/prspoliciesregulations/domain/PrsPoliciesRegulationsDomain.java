package com.inspur.cams.prs.prspoliciesregulations.domain;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.prs.prsattachment.dao.IPrsAttachmentDao;
import com.inspur.cams.prs.prsattachment.dao.PrsAttachment;
import com.inspur.cams.prs.prspoliciesregulations.dao.IPrsPoliciesRegulationsDao;
import com.inspur.cams.prs.prspoliciesregulations.dao.PrsPoliciesRegulations;

public class PrsPoliciesRegulationsDomain implements IPrsPoliciesRegulationsDomain{
	@Reference
	private IPrsPoliciesRegulationsDao prsPoliciesRegulationsDao;
	@Reference
	private IPrsAttachmentDao prsAttachmentDao;
	
	public void batchDelete(String[] delIds) {
		prsAttachmentDao.batchDeleteByPoliciesId(delIds);
		prsPoliciesRegulationsDao.batchDelete(delIds);
	}
	/**
	 * 政策法规的发布
	 */
	public void insertProblemDeal(ParameterSet pset,MultipartRequestWrapper wrapRequest) {
		Record record=(Record)pset.getParameter("record");
		PrsPoliciesRegulations bean=(PrsPoliciesRegulations)record.toBean(PrsPoliciesRegulations.class);
		bean.setPoliciesRegulationsId(IdHelp.getUUID32());
		bean.setYearly(Calendar.getInstance().get(Calendar.YEAR)+"");
		prsPoliciesRegulationsDao.insert(bean);
		
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
			attachment.setPoliciesRegulationsId(bean.getPoliciesRegulationsId());
			attachment.setUploadtime(DateUtil.getDay());
			attachment.setFileName(uploadfile.getFileName());
			attachment.setAttachment(uploadfile);
			list.add(attachment);
		}
		prsAttachmentDao.batchInsert(list);
	}

	public DataSet query(ParameterSet pset) {
		return prsPoliciesRegulationsDao.queryBySql(pset);
	}

	public void update(PrsPoliciesRegulations bean) {
		prsPoliciesRegulationsDao.update(bean);
	}
}
