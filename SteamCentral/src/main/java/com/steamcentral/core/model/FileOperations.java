package com.steamcentral.core.model;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Scanner;

public interface FileOperations {
	
	default void writeFile(String path, String content) {
		try(Writer writer = new OutputStreamWriter(new FileOutputStream(path), StandardCharsets.UTF_8)) {
			writer.write(content);
			writer.flush();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	default String readFile(String path) {
		try(Scanner sc = new Scanner(new File(path), "UTF-8")) {
			return sc.useDelimiter("\\Z").next();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	default void writeFileWithLock(String path, String content) {
        ByteBuffer buffer = ByteBuffer.wrap(content.getBytes(Charset.forName("UTF-8")));        
        Path pathToWrite = Paths.get(path);
        
        try {
	        FileChannel fileChannel = FileChannel.open(pathToWrite, StandardOpenOption.WRITE, StandardOpenOption.CREATE);
	        fileChannel.lock();
	        fileChannel.write(buffer);
	        fileChannel.close();
        } catch (IOException e) {
			e.printStackTrace();
		}
    }
	
	default String readFileWithLock(String path) {
		try(FileChannel fileChannel = FileChannel.open(Paths.get(path), StandardOpenOption.READ)) {
			fileChannel.lock(0, Long.MAX_VALUE, true);
            ByteBuffer buffer = ByteBuffer.allocate(1024);
            StringBuilder fileContent = new StringBuilder();
            
            while (fileChannel.read(buffer) != -1) {
                buffer.flip();
                fileContent.append(Charset.forName("UTF-8").decode(buffer));
                buffer.clear();
            }
            
            return fileContent.toString();
        } catch(IOException e) {
        	e.printStackTrace();
        }
		
        return null;
    }
}
