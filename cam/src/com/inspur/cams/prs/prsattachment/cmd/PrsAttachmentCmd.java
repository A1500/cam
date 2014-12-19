package com.inspur.cams.prs.prsattachment.cmd;

import java.util.List;
import java.util.Map;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.informUtil.InformCodec;
import com.inspur.cams.prs.prsattachment.domain.IPrsAttachmentDomain;

public class PrsAttachmentCmd extends BaseAjaxCommand{
	IPrsAttachmentDomain service=ScaComponentFactory.getService(IPrsAttachmentDomain.class,"PrsAttachmentDomain/PrsAttachmentDomain");
	@Trans
	public void queryAttachment(){
		String queryId=(String)getParameter("queryId");
		List<Map<String,Object>> list=service.queryByPoliciesId(queryId);
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
}
