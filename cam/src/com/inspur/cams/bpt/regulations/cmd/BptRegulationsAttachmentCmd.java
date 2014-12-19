package com.inspur.cams.bpt.regulations.cmd;

import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.regulations.dao.BptRegulationsAttachmentDao;
import com.inspur.cams.comm.informUtil.InformCodec;

public class BptRegulationsAttachmentCmd extends BaseAjaxCommand{
    private BptRegulationsAttachmentDao dao = (BptRegulationsAttachmentDao) DaoFactory.getDao(BptRegulationsAttachmentDao.class);
	public void queryAttachment(){
		String queryId=(String)getParameter("queryId");
		List<Map<String,Object>> list=dao.queryByRegulationId(queryId);
		StringBuffer fileName=new StringBuffer();
		StringBuffer attId=new StringBuffer();
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				fileName.append(list.get(i).get("FILE_NAME"));
				fileName.append("~");
				fileName.append(InformCodec.encode(list.get(i).get("FILE_NAME").toString()));
				fileName.append(",");
				
				attId.append(list.get(i).get("ATTACHMENT_ID"));
				attId.append(",");
			}
			if(fileName.length()>0){
				//去掉最后一个“,”
				fileName.deleteCharAt(fileName.length()-1);
				attId.deleteCharAt(attId.length()-1);
			}
			setReturn("fileName",fileName.toString());
			setReturn("attId",attId.toString());
		}else{
			setReturn("fileName","NoFile");
		}
	}
	
	//删除附件
	@Trans
	public void delete(){
		ParameterSet pset = getParameterSet();
		dao.deleteUploadFile(pset);
	}
}
