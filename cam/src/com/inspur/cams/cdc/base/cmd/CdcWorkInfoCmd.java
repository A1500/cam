package com.inspur.cams.cdc.base.cmd;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcWorkInfo;
import com.inspur.cams.cdc.base.domain.ICdcWorkInfoDomain;
import com.inspur.cams.comm.comfile.data.ComFile;
import com.inspur.cams.comm.comfile.domain.ComFileDomain;
import com.inspur.cams.comm.comfile.domain.IComFileDomain;
import com.inspur.cams.comm.lob.Blob;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基层民主与社区建设工作交流cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcWorkInfoCmd extends BaseAjaxCommand {

	private ICdcWorkInfoDomain cdcWorkInfoDomain = ScaComponentFactory
			.getService(ICdcWorkInfoDomain.class, "cdcWorkInfoDomain/cdcWorkInfoDomain");
	private IComFileDomain comFileDao = ScaComponentFactory.getService(ComFileDomain.class, "comFileDomain/comFileDomain");
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcWorkInfo cdcWorkInfo = (CdcWorkInfo) record.toBean(CdcWorkInfo.class);
		ComFile comFile= new ComFile();
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		while (iterator.hasNext()) {
			try {
				uploadfile = iterator.next().getValue();
				if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
					throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
				}
				// 如果为空，则不在进行对象封装，继续遍历下一条记录。
				if (uploadfile == null) {
					continue;
				}
				String fileName =uploadfile.getFileName();
				int size =uploadfile.getFileSize();
				
				comFile.setFileSize(BigDecimal.valueOf(size));
				Blob b= new Blob();
				b.setData(uploadfile.getFileData());
				comFile.setFileContent(b);
				comFile.setFileFormat(fileName.substring(fileName.lastIndexOf(".")+1));
				//comFile.setFileType((String)record.get("noticeType"));
				String fileId=getFix("yyyyMM")+IdHelp.getUUID30();
				comFile.setFileId(fileId);
				comFile.setApplyType("cdc");
				comFile.setFileName(fileName);
				comFile.setCreateTime(getFix("yyyy-MM-dd"));
				comFile.setCreateOpr((String)record.get("username"));
				comFile.setCreateOrgan((String)record.get("organName"));
				cdcWorkInfo.setFileId(fileId);
				comFileDao.save(comFile);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		cdcWorkInfo.setWorkType((String)record.get("workType"));
		cdcWorkInfo.setWorkId(getFix("yyyyMM")+IdHelp.getUUID30());
		cdcWorkInfo.setCreateTime(getFix("yyyy-MM-dd"));
		cdcWorkInfoDomain.insert(cdcWorkInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcWorkInfo cdcWorkInfo = (CdcWorkInfo) record.toBean(CdcWorkInfo.class);
		String fileId=(String)record.get("fileId");
		ComFile comFile = null;
		if(fileId!=null){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("FILE_ID", fileId);
			DataSet ds = comFileDao.find(pset);
			if(ds.getCount()>0){
				comFile=(ComFile)ds.getRecord(0).toBean(ComFile.class);
			}
		}
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		while (iterator.hasNext()) {
			try {
				uploadfile = iterator.next().getValue();
				if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
					throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
				}
				// 如果为空，则不在进行对象封装，继续遍历下一条记录。
				if (uploadfile == null) {
					continue;
				}
				String fileName =uploadfile.getFileName();
				int size =uploadfile.getFileSize();
				
				comFile.setFileSize(BigDecimal.valueOf(size));
				Blob b= new Blob();
				b.setData(uploadfile.getFileData());
				comFile.setFileContent(b);
				comFile.setFileFormat(fileName.substring(fileName.lastIndexOf(".")+1));
				comFile.setFileName(fileName);
				comFile.setApplyType("cdc");
				comFile.setCreateTime(getFix("yyyy-MM-dd"));
				comFile.setCreateOpr((String)record.get("username"));
				comFile.setCreateOrgan((String)record.get("organName"));
				if(fileId==null||"".equals(fileId)){
					fileId=getFix("yyyyMM")+IdHelp.getUUID30();
					comFile.setFileId(fileId);
					cdcWorkInfo.setFileId(fileId);
					comFileDao.save(comFile);
				}else {
					comFileDao.update(comFile);
				}
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		cdcWorkInfo.setCreateTime(getFix("yyyy-MM-dd"));
		
		cdcWorkInfoDomain.update(cdcWorkInfo);
	}

	// 删除
	public void delete() {
		String workId = (String) getParameter("workId");
		cdcWorkInfoDomain.delete(workId);
	}
	private String getFix(String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(new Date());
	}
}