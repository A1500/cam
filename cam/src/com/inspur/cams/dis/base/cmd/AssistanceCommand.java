package com.inspur.cams.dis.base.cmd;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.PubUtils;
import com.inspur.cams.dis.base.domain.IAssistanceDomain;

public class AssistanceCommand extends BaseAjaxCommand{
	private IAssistanceDomain assistanceDomain = ScaComponentFactory.getService(IAssistanceDomain.class,"assistanceDomain/assistanceDomain");
	@Trans
	public void save(){
		ParameterSet pset = getParameterSet();
		List<UploadFile> fileList = new ArrayList<UploadFile>();
		String isupload = (String) pset.getParameter("isupload");
		
		if(!PubUtils.isEmpty(isupload)) {
			if("true".equals(isupload)) {
				MultipartRequestWrapper request = null;
				try{
					request = (MultipartRequestWrapper) this.getRequest();
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				Map<String, UploadFile> fileMap = request.getUploadFiles();
				Set<String> keySet = fileMap.keySet();
				for(String key : keySet) {
					if(!PubUtils.isEmpty(key)) {
						UploadFile file = fileMap.get(key);
						fileList.add(file);
					}
				}
			}
		}
		
		//IDisPhotoDomain photoService = ScaComponentFactory.getService(IDisPhotoDomain.class, "DisPhotoDomain/DisPhotoDomain");
		//photoService.uploadDisPhoto(fileList);
		//assistanceDomain.save(pset);
		assistanceDomain.save(pset, fileList);
	}
	
	@Trans
	public void deleteBatch(){
		ParameterSet pset = getParameterSet();
		assistanceDomain.deleteBatch(pset);
	}
	
	@Trans
	public void selectBatch(){
		ParameterSet pset = getParameterSet();
		assistanceDomain.selectBatch(pset);
	}
}